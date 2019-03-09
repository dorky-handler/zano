; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Zano"
;#define MyAppVersion "0.2.0.31"
#define MyAppPublisher "Zano Team"
#define MyAppURL "http://zano.org"
#define MyAppExeName "Zano.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{65FD6D06-3A1D-47FF-AA45-2B302C1C9D8E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf64}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes
ChangesAssociations=yes
ArchitecturesInstallIn64BitMode=x64
WizardImageFile=../resources/installer_bg_164x313.bmp
;WizardSmallImageFile=../resources/icon.bmp
PrivilegesRequired=poweruser
ArchitecturesAllowed=x64
;SetupIconFile=../resources/app.ico
AppMutex=Zano_instance
UninstallDisplayIcon={app}\{#MyAppExeName}


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "desktopicon\common"; Description: "For all users"; GroupDescription: "{cm:AdditionalIcons}"; Flags: exclusive
Name: "desktopicon\user"; Description: "For the current user only"; GroupDescription: "{cm:AdditionalIcons}";  Flags: exclusive unchecked


[Registry]
Root: HKCR; Subkey: ".dbl"; ValueType: string; ValueName: ""; ValueData: "ZanoWalletDataFile"; Flags: uninsdeletevalue
Root: HKCR; Subkey: "ZanoWalletDataFile"; ValueType: string; ValueName: ""; ValueData: "Zano Wallet's Data File"; Flags: uninsdeletekey
Root: HKCR; Subkey: "ZanoWalletDataKyesFile"; ValueType: string; ValueName: ""; ValueData: "Zano Wallet's Keys File"; Flags: uninsdeletekey

Root: HKCR; Subkey: "ZanoWalletDataFile\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\Zano.exe,0"
Root: HKCR; Subkey: "ZanoWalletDataKyesFile\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\Zano.exe,0"


[Files]

Source: "{#BinariesPath}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs ignoreversion overwritereadonly replacesameversion
Source: "..\src\gui\qt-daemon\html\*"; DestDir: "{app}\html"; Flags: ignoreversion recursesubdirs ignoreversion overwritereadonly replacesameversion
Source: "{#BinariesPath}\vc_redist.x64.exe"; DestDir: {tmp}; Flags: deleteafterinstall
Source: "../resources/installer_bg_*.bmp"; Excludes: "*313.bmp"; Flags: dontcopy
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon\common
Name: "{userdesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon\user


[Run]
Filename: {tmp}\vc_redist.x64.exe; Parameters: "/install /quiet /norestart";  StatusMsg: Installing VC++ 2017 Redistributables...
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent shellexec

[UninstallDelete]
;This works only if it is installed in default location
Type: filesandordirs; Name: "{pf64}\{#MyAppName}"
;This works if it is installed in custom location
Type: files; Name: "{app}\*"; 
Type: filesandordirs; Name: "{app}"

; Choose the right wizard background image based on current windows font scale
; s.a.: https://stackoverflow.com/questions/26543603/inno-setup-wizardimagefile-looks-bad-with-font-scaling-on-windows-7
[Code]
function GetScalingFactor: Integer;
begin
  if WizardForm.Font.PixelsPerInch >= 144 then Result := 150
    else
  if WizardForm.Font.PixelsPerInch >= 120 then Result := 125
    else Result := 100;
end;

procedure LoadEmbededScaledBitmap(Image: TBitmapImage; NameBase: string);
var
  FileName: String;
begin
  ExtractTemporaryFile(NameBase);
  FileName := ExpandConstant('{tmp}\' + NameBase);
  Image.Bitmap.LoadFromFile(FileName);
  DeleteFile(FileName);
end;

procedure InitializeWizard;
begin
  { If using larger scaling, load the correct size of images }
  if GetScalingFactor = 125 then begin
    LoadEmbededScaledBitmap(WizardForm.WizardBitmapImage,  'installer_bg_191x385.bmp');
    LoadEmbededScaledBitmap(WizardForm.WizardBitmapImage2, 'installer_bg_191x385.bmp');
  end else if GetScalingFactor = 150 then begin
    LoadEmbededScaledBitmap(WizardForm.WizardBitmapImage,  'installer_bg_246x457.bmp');
    LoadEmbededScaledBitmap(WizardForm.WizardBitmapImage2, 'installer_bg_246x457.bmp');
  end;

end;

