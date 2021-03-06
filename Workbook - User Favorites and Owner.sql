SELECT
 s.name as Site_Name,
 u.friendly_name as User_Name,
 ai.usedobj_name as Workbook,
 'Favorite' as Type
FROM
  public.asset_lists al
  inner join sites s
  on al.site_id = s.id
  inner join _users u
  on u.id = al.owner_id
  inner join asset_list_items ai
  on ai.asset_list_id = al.id
  where al.name = 'favorites'
  and not exists (
  select 1
  from workbooks
  where workbooks.owner_id = al.owner_id)
  union all
select
s.name,
u.friendly_name,
w.name,
'Owner'
from _workbooks w inner join _sites s
on w.site_id = s.id
inner join _users u
on u.id = w.owner_id;