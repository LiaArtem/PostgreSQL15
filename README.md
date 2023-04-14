# PostgreSQL15
PostgreSQL integration with WEB-services (PL/Python -> HTTP method GET,POST and send e-mail, PL/pgSQL -> JSON, XML, CSV).
Add JSON Data Type (table, jsonb_path_query, json_build_object)

PostgreSQL 15 + Python 3.10
IDE - DBeaver
---------------------------------------------------------------------------------
Встановлення та налаштування:
---------------------------------------------------------------------------------
1) Встановлюємо Python 3
   - встановлюємо Python python-3.10.XXX-amd64.exe
     -> Use admin privileges when installing py.exe - увімкнути
     -> Add python.exe to PATH - увімкнути
     -> !!!! Customize installation
     -> Next
     -> Install Python 3.10 for all user - увімкнути
     -> Install
     -> Disable MAX_LIMIT – виконати.
     -> Завершити
   Перевантажити комп'ютер.

2) Встановлюємо PostgreSQL 15 (пароль: 12345678)

3) Розгортаємо базу даних:
   - Для виконання скриптів, налаштовуємо, щоб DB не запитувала пароль.
     - .\execute_sql_all\pg_hba_no_pwd\pg_hba.conf копіюємо і замінюємо файл c:\Program Files\PostgreSQL\15\data\pg_hba.conf
           (У файлі METHOD ставимо trust замість scram-sha-256)
     - Виконуємо скрипт .\execute_sql_all\execute_sql.bat
     - .\execute_sql_all\pg_hba_orig\pg_hba.conf копіюємо та замінюємо файл c:\Program Files\PostgreSQL\15\data\pg_hba.conf
           (Повертаємо назад, щоб запитувало пароль)

4) Створюємо з'єднання в DBeaver
   - хост: localhost
   - порт: 5432
   - база даних: test_database
   - Користувач: test_user
   - пароль: 12345678

5) Включаємо налагодження в PostgreSQL

   c:\Program Files\PostgreSQL\15\data\postgresql.conf правимо файл - міняємо
   з
    #shared_preload_libraries = ''# (change requires restart)
   на
    shared_preload_libraries = 'plugin_debugger' # (change requires restart)
   - Перезавантажити сервер.

---------------------------------------------------------------------------------
Backup (pgAdmin 4)
---------------------------------------------------------------------------------
   - Запускаємо pgAdmin 4
   - Servers -> Dashboard -> Configure pgAdmin -> Patch -> Binary patch
   - Поле PostgreSQL Binary Path = C: Program Files PostgreSQL 15 bin
   - На базі виконати Backup

---------------------------------------------------------------------------------
Backup (DBeaver)
---------------------------------------------------------------------------------
   - На базі правою клавішею -> Tools -> Backup
   - Зберігається в C:\Users\Admin\dump-test_database-202210142302.sql (приклад)
