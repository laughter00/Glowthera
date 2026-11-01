-- Glowthera user data table. Run this once in Supabase SQL Editor.
create table if not exists public.glowthera_user_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  morning_routine text not null default '',
  evening_routine text not null default '',
  habit_date date,
  habits jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.glowthera_user_data enable row level security;
drop policy if exists "Users can view their own Glowthera data" on public.glowthera_user_data;
create policy "Users can view their own Glowthera data" on public.glowthera_user_data for select to authenticated using (auth.uid() = user_id);
drop policy if exists "Users can insert their own Glowthera data" on public.glowthera_user_data;
create policy "Users can insert their own Glowthera data" on public.glowthera_user_data for insert to authenticated with check (auth.uid() = user_id);
drop policy if exists "Users can update their own Glowthera data" on public.glowthera_user_data;
create policy "Users can update their own Glowthera data" on public.glowthera_user_data for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
