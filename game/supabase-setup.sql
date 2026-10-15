-- Run in the Supabase SQL Editor. Public leaderboard, RPC-only score submission.
create table if not exists public.high_scores (
 id bigint generated always as identity primary key,
 initials text not null check (initials ~ '^[A-Z0-9]{1,3}$'),
 distance integer not null check (distance between 0 and 10000000),
 cash integer not null check (cash between 0 and 100000000 and cash % 100 = 0),
 near_miss_bonus integer not null check (near_miss_bonus between 0 and 100000000 and near_miss_bonus % 50 = 0),
 score bigint generated always as (distance::bigint + cash::bigint + near_miss_bonus::bigint) stored,
 created_at timestamptz not null default now()
);
create index if not exists high_scores_ranking on public.high_scores (score desc, created_at asc);
alter table public.high_scores enable row level security;
revoke all on public.high_scores from anon, authenticated;
grant select on public.high_scores to anon, authenticated;
drop policy if exists "Leaderboard is publicly readable" on public.high_scores;
create policy "Leaderboard is publicly readable" on public.high_scores for select to anon, authenticated using (true);
create or replace function public.submit_high_score(p_initials text, p_distance integer, p_cash integer, p_near_miss_bonus integer)
returns bigint language plpgsql security definer set search_path = '' as $$
declare v_id bigint;
begin
 if p_initials !~ '^[A-Za-z0-9]{1,3}$' or p_distance is null or p_distance < 1 or p_distance > 10000000
 or p_cash is null or p_cash < 0 or p_cash > 100000000 or p_cash % 100 <> 0
 or p_near_miss_bonus is null or p_near_miss_bonus < 0 or p_near_miss_bonus > 100000000 or p_near_miss_bonus % 50 <> 0
 then raise exception 'Invalid score'; end if;
 insert into public.high_scores(initials,distance,cash,near_miss_bonus)
 values(upper(p_initials),p_distance,p_cash,p_near_miss_bonus) returning id into v_id;
 return v_id;
end;$$;
revoke all on function public.submit_high_score(text,integer,integer,integer) from public;
grant execute on function public.submit_high_score(text,integer,integer,integer) to anon, authenticated;
-- IMPORTANT: This is basic input validation, NOT proof of a legitimate game run.
-- For a public competitive launch, move score verification to a trusted server,
-- use authenticated sessions and rate limiting, and validate run events/server-issued tokens.
