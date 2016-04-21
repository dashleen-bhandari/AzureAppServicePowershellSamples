# == How to create backups ==
# == Create a simple backup named backup without databases ==
$sasUrl = "https://account.blob.core.windows.net/backups?sv=2015-04-05&sr=b&sig=Z%2FRHIX5Xcg0Mq2rqI3OlWTjEg2tYkboXr1P9ZUXDtkk%3D&se=2015-04-30T02%3A23%3A26Z&sp=rw"

$backup = New-AzureRmWebAppBackup -ResourceGroupName "ResourceGroupName" -Name "Webapp Name" -BackupName "backup" -StorageAccountUrl $sasUrl

# == Create a backup with a database ==
$DB2 = New-AzureRmWebAppDatabaseBackupSetting -Name "Database Name1" -DatabaseType "SqlAzure" -ConnectionString "<connection_string>"
$DB1 = New-AzureRmWebAppDatabaseBackupSetting -Name "Database Name2" -DatabaseType "SqlAzure" -ConnectionString "<connection_string>"
$BackupDB = New-AzureRmWebAppBackup -ResourceGroupName "ResourceGroupName" -Name "Webapp Name" -BackupName "backup" -StorageAccountUrl $sasUrl -Databases $DB1,$DB2

# == Restore an app from a backup ==
$BackupDB | Restore-AzureRmWebAppBackup 

# Use Get-AzureRmWebAppBackupList to get a list of all backups for a web app
$backups = Get-AzureRmWebAppBackupList -Name "Webapp Name" -ResourceGroupName "ResourceGroupName"