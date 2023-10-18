set psql_source="c:\Program Files\PostgreSQL\15\bin\psql.exe"
set sql_source="d:\Прочие\Project\Project PostgreSQL\Project PostgreSQL 15"

%psql_source% -U postgres -d postgres --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\1_create_db_and_user\1_CREATE_DATABASE_AND_USER.sql

%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\2_sql_test_schemas\2_CREATE_SCHEMAS.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\2_sql_test_schemas\3_CREATE_TABLE_AND_VIEW.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\2_sql_test_schemas\4_CREATE_PROCEDURE.sql

%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\3_sql_p_check\1_CREATE_SCHEMA_p_check.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\3_sql_p_check\p_check.is_valid_xml.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\3_sql_p_check\p_check.is_valid_json.sql

%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\1_CREATE_SCHEMA_p_convert.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\p_convert.base64_decode.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\p_convert.base64_encode.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\p_convert.convert_str.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\p_convert.get_datetime.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\p_convert.num_spelled.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\p_convert.num_to_str.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\p_convert.str_amount.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\p_convert.str_amount_curr.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\p_convert.str_amount_format.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\p_convert.str_interest.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\p_convert.str_to_date.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\p_convert.str_to_num.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\p_convert.str_month.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\4_sql_p_convert\p_convert.str_days.sql

%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\5_sql_p_interface\1_CREATE_SCHEMA_p_interface.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\5_sql_p_interface\2_p_interface.t_erb_minfin.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\5_sql_p_interface\2_p_interface.t_fair_value.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\5_sql_p_interface\2_p_interface.t_isin_secur.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\5_sql_p_interface\3_p_interface.import_data_type.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\5_sql_p_interface\4_p_interface.add_import_data_type.sql

%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\5_sql_p_interface\p_interface.read_erb_minfin.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\5_sql_p_interface\p_interface.read_fair_value.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\5_sql_p_interface\p_interface.read_isin_secur.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\5_sql_p_interface\p_interface.read_kurs_nbu.sql

%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\6_sql_public\public.instr.sql

%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\7_create_extension\1_create_extension_plpython3u.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\7_create_extension\2_create_extension_pldbgapi.sql

%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\8_sql_p_service\1_CREATE_SCHEMA_p_service.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\8_sql_p_service\p_service.get.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\8_sql_p_service\p_service.post.sql
%psql_source% -U test_user -d test_database --log-file=%sql_source%\execute_sql_all\log.txt --file=%sql_source%\8_sql_p_service\p_service.send_email.sql

