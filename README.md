## My Photography Workflow 
### Built on windows using powershell, exiftool, XnConvert, FreeFileSync, Faststone Image Viewer, DigiKam, Lightroom, Nikon transfer, Microsoft import photos and videos from mobile

Because organyzing photos and videos from diffrent sources (multiple cameras and mobile phones) for those who like taking many photos is complicated, I have prepared this workflow to take advantage of diffrent softwares and end up with an clen library.

First consider the below folder structur for storing the files 

```
C: (script and exeutables)
├───PortableApps
│   └───PhotoWorkflow
│       ├───Arrange_pix.ps1
│       └───Elia_copyrights.txt
└───Program Files
    ├───. . .
    
D: (local machine storage)    
└───Photos
    ├───Import
    │   ├───Nikon Transfer
    │   ├───Mobile Photos
    │   └───Mobile Videos
    ├───Originals
    │   ├───Photos Sorted
    │   │   ├───JPG
    │   │   │   └───YYYY
    │   │   │       └───YYYY-MM
    │   │   └───RAW
    │   │       └───YYYY
    │   │           └───YYYY-MM
    │   └───Videos Sorted
    │       └───YYYY
    │           └───YYYY-MM
    ├───Exports
    │   ├───Lightroom Exports
    │   │   └───(Project Name)
    │   └───Videos Created
    │       └───(Project Name)
    ├───Small Size
    │   ├───Videos transcoded
    │   │   └───YYYY
    │   ├───Photos downsized
    │   │   └───YYYY
    │   │       └───YYYY-MM
    │   └───Sotial media pix
    │       └───YYYY
    │           └───YYYY-MM    
    └───Trash
        ├───Small Pix
        └───Other Files
 
M: (external HDD storage)    
└───Photos
    ├───Hight Resolution
    │   ├───Photos Sorted
    │   │   ├───JPG
    │   │   │   └───YYYY
    │   │   │       └───YYYY-MM
    │   │   └───RAW
    │   │       └───YYYY
    │   │           └───YYYY-MM
    │   ├───Lightroom Exports
    │   │   └───(Project Name)
    │   └───Videos Created
    │       └───(Project Name)
    ├───Low Resolution
    │   ├───Old Library
    │   │       └───(By Albumm Name)
    │   ├───New Library (JPG only includes Lightroom and social)
    │   │   └───YYYY
    │   │       └───YYYY-MM
    │   └───Videos (if TRANSCODED else SORTED)
    │       └───YYYY
    
    
```

Windows powershell script Arrange_pix.ps1



arguments file Elia_copyrights.txt
```powershell
-d
%Y
#Camera owner:
-OwnerName=Elia Harmouche

#Photographer's name: 
-IFD0:Artist=Elia Harmouche
-IPTC:By-line=Elia Harmouche
-XMP-dc:Creator=Elia Harmouche 


#Photographer's title:
-IPTC:By-lineTitle=Engineer
-XMP-photoshop:AuthorsPosition=Engineer

#Desired credit line:
-XMP-photoshop:Credit=Elia Harmouche

#Contact information — essential to avoid creating orphaned works:
-IPTC:Contact=email: eliaharm@gmail.com; website: http://eliaharm.com
-XMP-iptcCore:CreatorWorkEmail=eliaharm@gmail.com
-XMP-iptcCore:CreatorWorkURL=http://eliaharm.com

#Copyright information:
-IFD0:Copyright<Copyright © $createdate Elia Harmouche, all rights reserved.
-IPTC:CopyrightNotice<Copyright © $createdate Elia Harmouche, all rights reserved.
-XMP-dc:Rights<Copyright © $createdate Elia Harmouche, all rights reserved.
-XMP-xmpRights:UsageTerms=For consideration only, no reproduction without prior permission
 
```
