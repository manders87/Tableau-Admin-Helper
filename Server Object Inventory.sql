SELECT
  o.id,
  'PROJECT      ' AS object_type,
  o.name,
  'SITE           ' AS parent_object_type,
  o.site_id AS parent_id,
  o.created_at AS created,
  o.updated_at AS updated,
  u.friendly_name AS object_owner
FROM
  projects o
  INNER JOIN _users u ON (o.owner_id = u.id)

UNION ALL

SELECT
  o.id,
  'SITE      ' AS object_type,
  o.name,
  '             ' AS parent_object_type,
  null AS parent_id,
  o.created_at AS created,
  o.updated_at AS updated,
  NULL AS object_owner
FROM
  sites o

UNION ALL

SELECT
  o.id,
  'WORKBOOK      ' AS object_type,
  o.name,
  'PROJECT          ' AS parent_object_type,
  o.project_id AS parent_id,
  o.created_at AS created,
  o.updated_at AS updated,
  u.friendly_name AS object_owner
FROM
  workbooks o
  INNER JOIN _users u ON (o.owner_id = u.id)

UNION ALL

SELECT
  o.id,
  'DATASOURCE      ' AS object_type,
  o.name,
  'PROJECT          ' AS parent_object_type,
  o.project_id AS parent_id,
  o.created_at AS created,
  o.updated_at AS updated,
  u.friendly_name AS object_owner
FROM
  datasources o
  INNER JOIN _users u ON (o.owner_id = u.id)

UNION ALL

SELECT
  o.id,
  'VIEW      ' AS object_type,
  o.name,
  'WORKBOOK          ' AS parent_object_type,
  o.workbook_id AS parent_id,
  o.created_at AS created,
  o.updated_at AS updated,
  u.friendly_name AS object_owner
FROM
  views o
  INNER JOIN _users u ON (o.owner_id = u.id)
  order by id;
