# PostgreSQL15
PostgreSQL integration with WEB-services (PL/Python -> HTTP method GET,POST and send e-mail, PL/pgSQL -> JSON, XML, CSV).
Add JSON Data Type (table, jsonb_path_query, json_build_object)

PostgreSQL 15 + Python 3.10
IDE - DBeaver
---------------------------------------------------------------------------------
Установка и настройка:
---------------------------------------------------------------------------------
1) Устанавливаем Python 3
   - устанавливаем Python python-3.10.XXX-amd64.exe
     -> Use admin privileges when installing py.exe - включить
     -> Add python.exe to PATH - включить
     -> !!!! Customize installation
     -> Next
     -> Install Python 3.10 for all user - включить
     -> Install
     -> Disable MAX_LIMIT - выполнить.
     -> Завершить
   Перегрузить ПК.

2) Устанавливаем PostgreSQL 15 (пароль: 12345678)
3) Разворачиваем базу данных:
   - Для выполнения скриптов, настраиваем чтобы DB не запрашивала пароль.
     - .\execute_sql_all\pg_hba_no_pwd\pg_hba.conf копируем и заменяем файл c:\Program Files\PostgreSQL\15\data\pg_hba.conf
           (в файле METHOD ставим trust вместо scram-sha-256)
     - выполняем скрипт .\execute_sql_all\execute_sql.bat
     - .\execute_sql_all\pg_hba_orig\pg_hba.conf копируем и заменяем файл c:\Program Files\PostgreSQL\15\data\pg_hba.conf
           (возвращаем обратно чтобы запрашивало пароль)

4) Создаем соединение в DBeaver
   - хост: localhost
   - порт: 5432
   - база данных: test_database
   - пользователь: test_user
   - пароль: 12345678

5) Включаем отладку в PostgreSQL

   c:\Program Files\PostgreSQL\15\data\postgresql.conf правим файл - меняем
   с
    #shared_preload_libraries = '' # (change requires restart)
   на
    shared_preload_libraries = 'plugin_debugger' # (change requires restart)
   - Перезагрузить сервер.

---------------------------------------------------------------------------------
Backup (pgAdmin 4)
---------------------------------------------------------------------------------
   - Запускаем pgAdmin 4
   - Servers -> Dashboard -> Configure pgAdmin -> Patch -> Binary patch
   - Поле PostgreSQL Binary Path = C:\Program Files\PostgreSQL\15\bin\
   - На базе выполнить Backup

---------------------------------------------------------------------------------
Backup (DBeaver)
---------------------------------------------------------------------------------
   - На базе правой клавишей -> Tools -> Backup
   - Хранится в C:\Users\Admin\dump-test_database-202210142302.sql (пример)
