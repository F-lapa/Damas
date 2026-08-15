-- Rode este SQL no Supabase (SQL Editor) UMA VEZ:
-- Dashboard → SQL Editor → New query → cole → Run

create table if not exists public.lobby_online (
  username text primary key,
  status text default 'available',
  game_id text,
  opp text,
  updated_at timestamptz default now()
);

alter table public.lobby_online enable row level security;

-- Politicas abertas para o app (anon key)
drop policy if exists "lobby_online_read" on public.lobby_online;
drop policy if exists "lobby_online_write" on public.lobby_online;
drop policy if exists "lobby_online_update" on public.lobby_online;
drop policy if exists "lobby_online_delete" on public.lobby_online;

create policy "lobby_online_read" on public.lobby_online
  for select using (true);

create policy "lobby_online_write" on public.lobby_online
  for insert with check (true);

create policy "lobby_online_update" on public.lobby_online
  for update using (true);

create policy "lobby_online_delete" on public.lobby_online
  for delete using (true);

-- Index para buscar quem esta online
create index if not exists lobby_online_updated_at_idx on public.lobby_online (updated_at desc);
