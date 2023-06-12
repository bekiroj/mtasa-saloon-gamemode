-- MySQL sınıfı tanımlama
mysql = {}
mysql.__index = mysql

-- MYSQL BİLGİLERİ
mysql.database = 'mta'
mysql.username = 'root'
mysql.password = 'vintagegs10'
mysql.hostname = '127.0.0.1'
mysql.port = 3306

-- Yeni bir MySQL nesnesi oluşturma işlevi
function mysql:new(database, username, password, hostname, port)
    -- Veritabanına bağlanma
    self.connection = dbConnect("mysql", "dbname=" .. database .. ";host=" .. hostname .. ";port=" .. port, username, password)
    if self.connection then
        outputDebugString('database connection successful')
    else
        outputDebugString('database connection failed')
    end
    return true
end

function mysql:getConn(connectionName)
    return self.connection
end

function getConn(...)
    return mysql:getConn(...)
end

mysql:new(mysql.database,mysql.username,mysql.password,mysql.hostname,mysql.port)