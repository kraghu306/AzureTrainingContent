
$SubscriptionName="MSDNAzureUltimate"           #"<subscription name>"
$StorageAccountName="teststa1122016"                #"<storage account name>"
$Location = "West US"                 #"<Location>"
$ContainerName = "imagecontainer"     #"<Container name>"
$ImageToUpload = "H:\Images\index.jpg" 
$DestinationFolder = "H:\DownloadedImages"
Add-AzureAccount
Select-AzureSubscription -SubscriptionName $SubscriptionName –Current
# Create a new storage account.
New-AzureStorageAccount –StorageAccountName $StorageAccountName -Location $Location
# Set a default storage account.
Set-AzureSubscription -CurrentStorageAccountName $StorageAccountName -SubscriptionName $SubscriptionName

# Create a new container.
New-AzureStorageContainer -Name $ContainerName -Permission Off

# Upload a blob into a container.
Set-AzureStorageBlobContent -Container $ContainerName -File $ImageToUpload

# List all blobs in a container.
Get-AzureStorageBlob -Container $ContainerName

# Download blobs from the container:
# Get a reference to a list of all blobs in a container.
$blobs = Get-AzureStorageBlob -Container $ContainerName

# Create the destination directory.
New-Item -Path $DestinationFolder -ItemType Directory -Force  

# Download blobs into the local destination directory.
$blobs | Get-AzureStorageBlobContent –Destination $DestinationFolder
#end
