CREATE OR REPLACE FUNCTION p_convert.str_amount(p_amount numeric, p_is_default character DEFAULT 'T'::bpchar)
 RETURNS character varying
 LANGUAGE plpgsql
 STABLE
AS $function$
DECLARE
    -- �������������� ����� � �����    
    dig       varchar(255)[];
    dig_a     varchar(255)[];
    ten       varchar(255)[];
    hun       varchar(255)[];
    tis       varchar(255)[];
    mln       varchar(255)[];
    mlrd      varchar(255)[];
    i         numeric := 0;
    CurrValue numeric;
    S         numeric;
    p_result  varchar(255) := '';
    DIGIT     varchar(255) := '';
    RADIX     varchar(255) := '';

begin	
    CurrValue := trunc(p_amount);
    -- ������
    tis[0] := '����� ';
    tis[1] := '������ ';
    tis[2] := '�����i ';
    tis[3] := '�����i ';
    tis[4] := '�����i ';
    tis[5] := '����� ';
    tis[6] := '����� ';
    tis[7] := '����� ';
    tis[8] := '����� ';
    tis[9] := '����� ';
    tis[10] := '����� ';
    tis[11] := '����� ';
    tis[12] := '����� ';
    tis[13] := '����� ';
    tis[14] := '����� ';
    tis[15] := '����� ';
    tis[16] := '����� ';
    tis[17] := '����� ';
    tis[18] := '����� ';
    tis[19] := '����� ';   
    -- �i�����
    mln[0] := '�i�����i� ';
    mln[1] := '�i����� ';
    mln[2] := '�i������ ';
    mln[3] := '�i������ ';
    mln[4] := '�i������ ';
    mln[5] := '�i�����i� ';
    mln[6] := '�i�����i� ';
    mln[7] := '�i�����i� ';
    mln[8] := '�i�����i� ';
    mln[9] := '�i�����i� ';
    mln[10] := '�i�����i� ';
    mln[11] := '�i�����i� ';
    mln[12] := '�i�����i� ';
    mln[13] := '�i�����i� ';
    mln[14] := '�i�����i� ';
    mln[15] := '�i�����i� ';
    mln[16] := '�i�����i� ';
    mln[17] := '�i�����i� ';
    mln[18] := '�i�����i� ';
    mln[19] := '�i�����i� ';
    -- �i�����i�
    mlrd[0] := ' ';
    mlrd[1] := '�i����� ';
    mlrd[2] := '�i������ ';
    mlrd[3] := '�i������ ';
    mlrd[4] := '�i������ ';
    mlrd[5] := '�i�����i� ';
    mlrd[6] := '�i�����i� ';
    mlrd[7] := '�i�����i� ';
    mlrd[8] := '�i�����i� ';
    mlrd[9] := '�i�����i� ';
    mlrd[10] := '�i�����i� ';
    mlrd[11] := '�i�����i� ';
    mlrd[12] := '�i�����i� ';
    mlrd[13] := '�i�����i� ';
    mlrd[14] := '�i�����i� ';
    mlrd[15] := '�i�����i� ';
    mlrd[16] := '�i�����i� ';
    mlrd[17] := '�i�����i� ';
    mlrd[18] := '�i�����i� ';
    mlrd[19] := '�i�����i� ';

    Dig[0] := '';
    dig[1] := '���� ';
    dig[2] := '��� ';
    dig[3] := '��� ';
    dig[4] := '������ ';
    dig[5] := '�''��� ';
    dig[6] := '�i��� ';
    dig[7] := '�i� ';
    dig[8] := '�i�i� ';
    dig[9] := '���''��� ';
    dig[10] := '������ ';
    dig[11] := '���������� ';
    dig[12] := '���������� ';
    dig[13] := '���������� ';
    dig[14] := '������������ ';
    dig[15] := '�''��������� ';
    dig[16] := '�i��������� ';
    dig[17] := '�i�������� ';
    dig[18] := '�i�i�������� ';
    dig[19] := '���''��������� ';

    Dig_a[0] := '';
    dig_a[1] := '���� ';
    dig_a[2] := '��i ';
    dig_a[3] := '��� ';
    dig_a[4] := '������ ';
    dig_a[5] := '�''��� ';
    dig_a[6] := '�i��� ';
    dig_a[7] := '�i� ';
    dig_a[8] := '�i�i� ';
    dig_a[9] := '���''��� ';
    dig_a[10] := '������ ';
    dig_a[11] := '���������� ';
    dig_a[12] := '���������� ';
    dig_a[13] := '���������� ';
    dig_a[14] := '������������ ';
    dig_a[15] := '�''��������� ';
    dig_a[16] := '�i��������� ';
    dig_a[17] := '�i�������� ';
    dig_a[18] := '�i�i�������� ';
    dig_a[19] := '���''��������� ';

    ten[0] := '';
    ten[1] := '';
    ten[2] := '�������� ';
    ten[3] := '�������� ';
    ten[4] := '����� ';
    ten[5] := '�''������� ';
    ten[6] := '�i������� ';
    ten[7] := '�i������ ';
    ten[8] := '�i�i������ ';
    ten[9] := '���''������ ';

    Hun[0] := '';
    Hun[1] := '��� ';
    Hun[2] := '��i��i ';
    Hun[3] := '������ ';
    Hun[4] := '��������� ';
    Hun[5] := '�''����� ';
    Hun[6] := '�i����� ';
    Hun[7] := '�i���� ';
    Hun[8] := '�i�i���� ';
    Hun[9] := '���''����� ';

    if Currvalue = 0
    then
      p_result := '���� ';
    else
      while CurrValue > 0
      loop
        if (CurrValue % 1000) <> 0 
        then 
          S := CurrValue % 100;
          if S < 20 then

            if i <= 1 then
              if p_is_default = 'T' 
              then
                DIGIT := dig_a[s];
              else
                if i = 1 then
                  DIGIT := dig_a[s];
                else
                  DIGIT := dig[s];
                end if;
              end if;
            else
              DIGIT := dig[s];
            end if;

            if i = 0 then
              RADIX := '';
            elsif i = 1 then
              RADIX := tis[s];
            elsif i = 2 then
              RADIX := mln[s];
            elsif i = 3 then
              RADIX := mlrd[s];
            end if;

            p_result := DIGIT||RADIX|| p_result;
          else

            if i <= 1 then
              if p_is_default = 'T' then
                DIGIT := dig_a[mod(s, 10)];
              else
                DIGIT := dig[mod(s, 10)];
              end if;
            else
              DIGIT := dig[mod(s, 10)];
            end if;

            if i = 0 then
              RADIX := '';
            elsif i = 1 then
              RADIX := tis[mod(s, 10)];
            elsif i = 2 then
              begin
              if mod(s, 10) = 0 then
                 RADIX := mln[5];
              else
                 RADIX := mln[mod(s, 10)];
              end if;
              end;
            elsif i = 3 then
              begin
              if mod(s, 10) = 0 then
                 RADIX := mlrd[5];
              else
                 RADIX := mlrd[mod(s, 10)];
              end if;
              end;
            end if;

            p_result := Ten[trunc(S/10)]||DIGIT||RADIX||p_result;

          end if;
          CurrValue := trunc(CurrValue/100);
          S := CurrValue % 10;
          p_result := Hun[S] ||p_result;
          CurrValue := trunc(CurrValue/10);
          i := i + 1;
        else
          CurrValue := trunc(CurrValue/1000);
          i := i + 1;
        end if;
      end loop;
    end if;

    p_result := upper(substr(p_result, 1, 1))||substr(p_result, 2, 254);
    return(trim(both substr(p_result, 1, 255)));

  exception when others
  then 
    return null;
  end;

$function$
;
