  SELECT  P.*,x.get_content_ids_with_different_permissions_templates_from_proje as Exception_Object_Id,  d.name as Exception_Object, 'Datasource' Exception_Object_Type 
  from public.projects p
  join lateral
  (select * from get_content_ids_with_different_permissions_templates_from_proje(
  'Datasource',
  p.id,
  'Datasource',
  array(select id from datasources where project_id = p.id),
  array (select id from capabilities)))x
  on true
  left join datasources d on
  d.id = x.get_content_ids_with_different_permissions_templates_from_proje

  union

  SELECT  P.*,x.get_content_ids_with_different_permissions_templates_from_proje,  W.name, 'Workbook'
  from public.projects p
  join lateral
  (select * from get_content_ids_with_different_permissions_templates_from_proje(
  'Workbook',
  p.id,
  'Workbook',
  array(select id from workbooks where project_id = p.id),
  array (select id from capabilities)))x
  on true
  left join workbooks w
  on w.id = x.get_content_ids_with_different_permissions_templates_from_proje

  union
    SELECT  P.*,x.get_content_ids_with_different_permissions_templates_from_proje,  v.name, 'View'
  from public.projects p
  join lateral
  (select * from get_content_ids_with_different_permissions_templates_from_proje(
  'Workbook',
  p.id,
  'View',
  array(select v.id from views v inner join workbooks w on v.workbook_id = w.id where project_id = p.id),
  array (select id from capabilities)))x
  on true
  left join views v
  on v.id = x.get_content_ids_with_different_permissions_templates_from_proje
  order by Exception_Object_Type; 

