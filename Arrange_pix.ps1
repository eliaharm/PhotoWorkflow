#################################################################################
#                                                                               #
# Author    : Elia Harmouche 2017                                               #
# Purpose   : Windows PowerShell script to automate my photography workflow     #
# Software  : ExifTool by Phil Harvey to Read, Write and Edit Meta Information  #
#                                                                               #
#################################################################################

# Set-ExecutionPolicy RemoteSigned
# clear powershell command screen
cls; 
# Set Alias for application and filders and files path
new-alias et "C:\PortableApps\exiftool.exe"
$argfile="C:\PortableApps\Elia_copyrights.txt"
# All photes imported from cameras, phones and SD cards are stored here
$srcfolder="D:\Photos\Photos Nikon Transfer\131\test"
# Final destination for Original photos
$destfolder="D:\Photos\Photos Nikon Transfer\131\test"
$destfolderjpg="D:\Photos\Photos Nikon Transfer\131\test"
$destfolderraw="D:\Photos\Photos Nikon Transfer\131\test"
# Files conditionally moved here to be deleted
$trashfolder="D:\Photos\Photos Nikon Transfer\131\trash"


## Step 2 move whatsapp sent images to destination


## Step 3 move whatsapp received images to destination


## Step 4 move videos


##  delete tumbnails and small junky images
# et -P -m -q -q "-Directory<$trashfolder" -if "$ImageHeight<1000"  $srcfolder
# et -P -m -q -q "-Directory<$trashfolder" -if "$ImageWidth<1000"  $srcfolder
# exiftool -filename -filemodifydate -createdate -r -if '(not $datetimeoriginal) and $filetype eq "JPEG"' 

## Update all copyright information from arguments file and 
## automatically fix any errors in exif data without showing errors
et  -P -F -m -q -q -@ $argfile -sep "; " -struct -overwrite_original -r $srcfolder

## Fill description with Aperture, Shutter speed, ISO, Focal Length, Focus Mode, Flash Mode, White Balance... info
## + Photographer, camera make and model...
# todo

## Use Exiftool to change the system file modification date to match the image createdate:
# exiftool '-filemodifydate<createdate' 
## Fill createdate with filemodifydate if datetimeoriginal empty
# exiftool -createdate<filemodifydate -r -if '(not $datetimeoriginal or ($datetimeoriginal eq "0000:00:00 00:00:00")) and ($filetype eq "JPEG")' .

## Move raw and jpg to apropriate folders and sort and rename by date
et -P '-filename<${CreateDate}-${make}-${filenumber}%-c.%le' -d "${destfolder}\%Y\%Y%m\%Y%m%d_%H%M%S" -ext jpg -ext jpeg -ext gif -ext png -ext mpo $srcfolder
et -P '-filename<${CreateDate}-${make}-${filenumber}%-c.%le' -d "${destfolder}\%Y\%Y%m\%Y%m%d_%H%M%S" -ext nef -ext cr2 -ext dng -ext rw2 -ext tif $srcfolder

#et  -P '-TagsList+<${FileName}' $srcfolder


et  -P '-TagsList+<FileName' '-TagsList+<Directory' -overwrite_original -r $srcfolder

##Clear a tag
#et  -P '-TagsList=' $srcfolder


##view tag labels for a group
#et -args -IPTC:* $srcfolder

#et -P '-filename<$CreateDate' -d "D:\Photos\Photos Nikon Transfer\131\test%y%m%d_%H%M%S%%-c.%%le"  $srcfolder

# WORKINGGG!!!!
#et -P '-filename<${CreateDate}-${make}-${filenumber}%-c.%le' -d "D:\Photos\Photos Nikon Transfer\131\test\%Y\%Y%m\%Y%m%d-%H%M%S"   $srcfolder

#C:\PortableApps\exiftool.exe -P '-filename<${CreateDate}-${make}-${filename}%-c.%le' -d "%Y%m%d-%H%M%S"   $srcfolder

# WORKINGGG!!!! FINAL :)
#et -P '-filename<${CreateDate}-${make}-${filenumber}%-c.%le' -d "${destfolder}\%Y\%Y%m\%Y%m%d_%H%M%S"   $srcfolder


et -P -TagsList  $srcfolder

