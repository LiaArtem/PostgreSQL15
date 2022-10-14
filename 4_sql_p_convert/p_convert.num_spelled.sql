create or replace function p_convert.num_spelled_int (
  n numeric,
  g char,
  d text[]
) returns text
language plpgsql as $BODY$
declare
  r text;
  s text[];
begin
  r := ltrim(to_char(n, '9,9,,9,,,,,,9,9,,9,,,,,9,9,,9,,,,9,9,,9,,,.')) || '.';

  if array_upper(d,1) = 1 and d[1] is not null then
    s := array[ d[1], d[1], d[1] ];
  else
    s := array[ coalesce(d[1],''), coalesce(d[2],''), coalesce(d[3],'') ];
  end if;

  --t - ������; m - �������; M - ���������;
  r := replace( r, ',,,,,,', 'eM');
  r := replace( r, ',,,,,', 'em');
  r := replace( r, ',,,,', 'et');
  --e - �������; d - �������; c - �����;
  r := replace( r, ',,,', 'e');
  r := replace( r, ',,', 'd');
  r := replace( r, ',', 'c');
  --�������� ���������� �����
  r := replace( r, '0c0d0et', '');
  r := replace( r, '0c0d0em', '');
  r := replace( r, '0c0d0eM', '');

  --�����
  r := replace( r, '0c', '');
  r := replace( r, '1c', '��� ');
  r := replace( r, '2c', '������ ');
  r := replace( r, '3c', '������ ');
  r := replace( r, '4c', '��������� ');
  r := replace( r, '5c', '������� ');
  r := replace( r, '6c', '�������� ');
  r := replace( r, '7c', '������� ');
  r := replace( r, '8c', '��������� ');
  r := replace( r, '9c', '��������� ');

  --�������
  r := replace( r, '1d0e', '������ ');
  r := replace( r, '1d1e', '����������� ');
  r := replace( r, '1d2e', '���������� ');
  r := replace( r, '1d3e', '���������� ');
  r := replace( r, '1d4e', '������������ ');
  r := replace( r, '1d5e', '���������� ');
  r := replace( r, '1d6e', '����������� ');
  r := replace( r, '1d7e', '���������� ');
  r := replace( r, '1d8e', '������������ ');
  r := replace( r, '1d9e', '������������ ');
  r := replace( r, '0d', '');
  r := replace( r, '2d', '�������� ');
  r := replace( r, '3d', '�������� ');
  r := replace( r, '4d', '����� ');
  r := replace( r, '5d', '��������� ');
  r := replace( r, '6d', '���������� ');
  r := replace( r, '7d', '��������� ');
  r := replace( r, '8d', '����������� ');
  r := replace( r, '9d', '��������� ');

  --�������
  r := replace( r, '0e', '');
  r := replace( r, '5e', '���� ');
  r := replace( r, '6e', '����� ');
  r := replace( r, '7e', '���� ');
  r := replace( r, '8e', '������ ');
  r := replace( r, '9e', '������ ');

  if g = 'M' then
    r := replace( r, '1e.', '���� !'||s[1]||' '); --���� �����
    r := replace( r, '2e.', '��� !'||s[2]||' '); --��� �����
  elsif g = 'F' then
    r := replace( r, '1e.', '���� !'||s[1]||' '); --���� �����
    r := replace( r, '2e.', '��� !'||s[2]||' '); --��� �����
  elsif g = 'N' then
    r := replace( r, '1e.', '���� !'||s[1]||' '); --���� �����
    r := replace( r, '2e.', '��� !'||s[2]||' '); --��� �����
  end if;
  r := replace( r, '3e.', '��� !'||s[2]||' ');
  r := replace( r, '4e.', '������ !'||s[2]||' ');

  r := replace( r, '1et', '���� ������ ');
  r := replace( r, '2et', '��� ������ ');
  r := replace( r, '3et', '��� ������ ');
  r := replace( r, '4et', '������ ������ ');
  r := replace( r, '1em', '���� ������� ');
  r := replace( r, '2em', '��� �������� ');
  r := replace( r, '3em', '��� �������� ');
  r := replace( r, '4em', '������ �������� ');
  r := replace( r, '1eM', '���� ������� ');
  r := replace( r, '2eM', '��� �������� ');
  r := replace( r, '3eM', '��� �������� ');
  r := replace( r, '4eM', '������ �������� ');

  r := replace( r, 't', '����� ');
  r := replace( r, 'm', '��������� ');
  r := replace( r, 'M', '��������� ');

  r := replace( r, '.', ' !'||s[3]||' ');

  if n = 0 then
    r := '���� ' || r;
  end if;

  return r;
end;
$BODY$;

/*
select
  n,
  _num_spelled(n, 'M', '{�����,�����,������}'),
  _num_spelled(n, 'F', '{�������,�������,������}'),
  _num_spelled(n, 'N', '{����}')
from (values(0),(1),(2),(3),(5),(10),(11),(20),(21),(22),(23),(25),(45678),(1234567),(78473298395)) t(n);
*/

create or replace function p_convert.num_spelled (
  source_number    numeric,
  int_unit_gender  char,
  int_units        text[],
  frac_unit_gender char,
  frac_units       text[],
  frac_format      text
) returns text
language plpgsql as $BODY$
declare
  i numeric;
  f numeric;
  fmt text;
  fs  text;
  s int := 0;
  result text;
begin
  i := trunc(abs(source_number));
  fmt := regexp_replace(frac_format, '[^09]', '', 'g');
  s := char_length(fmt);
  f := round((abs(source_number) - i) * pow(10, s));
  
  result := num_spelled_int(i, int_unit_gender, int_units);
  fs := num_spelled_int(f, frac_unit_gender, frac_units);

  if coalesce(s,0) > 0 then --������� �����
    if frac_format like '%d%' then --�������
      fs := to_char(f, fmt) || ' ' || substring(fs, '!.*');
    end if;
    if frac_format like '%m%' then --����� ����� ������ � ��.���.
      result := replace(result, '!', ', '||fs||' ');
    else --� �����
      result := result || ' ' || fs;
    end if;
  end if;
  result := replace(result, '!', '');
  result := regexp_replace(result, ' +', ' ', 'g'); --������ �������
  result := replace(result, ' ,', ',');

  if source_number < 0 then
    result := '����� ' || result;
  end if;
  
  return trim(result);
end;
$BODY$;

comment on function p_convert.num_spelled (
  source_number    numeric,
  int_unit_gender  char,
  int_units        text[],
  frac_unit_gender char,
  frac_units       text[],
  frac_format      text
) is
$$����� ��������.
source_number    numeric   �������� �����
int_unit_gender  char      ��� ����� ������� ��������� (F/M/N)
int_units        text[]    �������� ����� ������ (3 ��������):
                           [1] - 1 �����/1 �����/1 �����
                           [2] - 2 �����/2 �����/2 �����
                           [3] - 0 ������/0 ����/0 ����
frac_unit_gender char      ��� ������� ������� ��������� (F/M/N)
frac_units       text      �������� ������� ������ (3 ��������):
                           [1] - 1 �����/1 �������
                           [2] - 2 ������/2 �������
                           [3] - 0 �������/0 ������
frac_format      text      ����� ������� �������� �����:
                           '0' - ����� ��������, � �������� ������
                           '9' - ����� ��������, ��� ������� �����
                           't' - ������� ('00t' -> ������ ����� �������� ������)
                           'd' - ������� ('00d' -> ������ ����� 20 ������)
                           'm' - �������� ������� ����� ����� �������� ��������� ����� �����
                             ('00dm' -> ������, 20 �����)
$$;

/*
select
  n,
  num_spelled(n, 'M', '{�����,�����,������}', 'F', '{�������,�������,������}', '00t'),
  num_spelled(n, 'M', '{�����,�����,������}', 'F', '{�������,�������,������}', '00d'),
  num_spelled(n, 'M', '{�����,�����,������}', 'F', NULL, '00dm'),
  num_spelled(n, 'N', '{����}', 'M', '{����,�����,������}', '00t'),
  num_spelled(n, 'F', '{�����,�����,����}', NULL, NULL, NULL),
  num_spelled(n, 'F', '{"��,"}', 'M', '{��}', '999d')
from (values(0),(1),(1.23),(45.678),(12345.67),(-1),(-123.45)) t(n);
*/

