{ +--------------------------------------------------------------------------+ }
{ | CHC v0.2 * Chocking coil sizing application                              | }
{ | Copyright (C) 2012-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmmain.pas                                                              | }
{ | Main form                                                                | }
{ +--------------------------------------------------------------------------+ }

{
  This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or (at your
option) any later version.

  This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

  You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
}

unit frmmain;
{$MODE OBJFPC}{$H+}
interface
uses
  {$IFDEF WIN32} Windows, {$ENDIF} Classes, SysUtils, FileUtil, Forms, Controls,
  Graphics, Dialogs, StdCtrls, Spin, ExtCtrls, Buttons, dos,
  frmabout, gettext;
type
  { TForm1 }
  TForm1 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    FloatSpinEdit1: TFloatSpinEdit;
    FloatSpinEdit2: TFloatSpinEdit;
    FloatSpinEdit3: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FloatSpinEdit1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 
var
  exepath, p: shortstring;
  Form1: TForm1;
  I: single;
  L: single;
  lang: string[2];
  lr: single;
  A: single;
  Ai: single;
  ni: single;
  di: single;
  s: string;
  saved: boolean;
  userdir: string;
const
  VERSION='0.2';
  APPNAME='CHC';
 {$IFDEF WIN32}
  CSIDL_PROFILE = 40;
  SHGFP_TYPE_CURRENT = 0;
 {$ENDIF}

 {$IFDEF UNIX}
  {$I config.inc}
 {$ENDIF}

resourcestring
  MESSAGE01='Error, please check values!';
  MESSAGE02='Save to file';
  MESSAGE03='result.txt';
  MESSAGE04='This file is exists, overwrite?';
  MESSAGE05='text files (*.txt)|*.txt|';
  MESSAGE06='Error, cannot write this file!';
  MESSAGE07='Do you want to save result?';
  MESSAGE08='EI core choking coil';

{$IFDEF WIN32}
function SHGetFolderPath(hwndOwner: HWND; nFolder: Integer; hToken: THandle;
         dwFlags: DWORD; pszPath: LPTSTR): HRESULT; stdcall;
         external 'Shell32.dll' name 'SHGetFolderPathA';
{$ENDIF}

implementation
{$R *.lfm}
{ TForm1 }

{$IFDEF WIN32}
function GetUserProfile: string;
var
  Buffer: array[0..MAX_PATH] of Char;
begin
  FillChar(Buffer, SizeOf(Buffer), 0);
  SHGetFolderPath(0, CSIDL_PROFILE, 0, SHGFP_TYPE_CURRENT, Buffer);
  Result := String(PChar(@Buffer));
end;
{$ENDIF}

// start sizing
procedure TForm1.Button2Click(Sender: TObject);
var
  s: string;
begin
  try
    I:=FloatSpinEdit1.Value;
    L:=FloatSpinEdit2.Value;
    lr:=FloatSpinEdit3.Value;
    A:=(L*I*I)/(20000*lr); str(A:0:2,s); Edit1.Text:=s;
    ni:=(400000*lr)/I; str(ni:0:0,s); Edit3.Text:=s;
    di:=0.025*sqrt(I); str(di:0:2,s); Edit4.Text:=s;
    Ai:=(ni*di*di)/100; str(Ai:0:2,s); Edit2.Text:=s;
  except
    Edit1.Clear;
    Edit2.Clear;
    Edit3.Clear;
    Edit4.Clear;
    showmessage(MESSAGE01);
  end;
end;

// close box
procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

// open about box
procedure TForm1.Button3Click(Sender: TObject);
begin
  Form2.Show;
end;

// save result
procedure TForm1.Button4Click(Sender: TObject);
var
  f: textfile;
  tfdir, tfname, tfext: shortstring;
  s: string;
  b: byte;
begin
  Button2Click(Sender);
  Form1.SaveDialog1.InitialDir:=userdir;
  Form1.SaveDialog1.Title:=MESSAGE02;
  Form1.SaveDialog1.Filter:=MESSAGE05;
  Form1.SaveDialog1.FilterIndex:=1;
  Form1.SaveDialog1.Filename:=MESSAGE03;
  if Form1.SaveDialog1.Execute=false then exit;
  s:=Form1.SaveDialog1.FileName;
  if length(s)=0 then exit;
  fsplit(s,tfdir,tfname,tfext);
  if FSearch(tfname+tfext,tfdir)<>'' then
    if MessageDlg(MESSAGE04,mtConfirmation, [mbYes, mbNo],0)=mrNo then exit;
  assignfile(f,Form1.SaveDialog1.FileName);
  try
    rewrite(f);
    writeln(f,MESSAGE08);
    for b:=1 to length(MESSAGE08) do
    write(f,'~');writeln(f,'');
    writeln(f,' '+Label1.Caption+':'+#9,FloatSpinEdit1.Value:0:0,' '+Label3.Caption);
    writeln(f,' '+Label2.Caption+':'+#9,FloatSpinEdit2.Value:0:1,' '+Label4.Caption);
    writeln(f,' '+Label5.Caption+':'+#9,FloatSpinEdit3.Value:0:1,' '+Label6.Caption);
    writeln(f,'');
    writeln(f,' '+Label7.Caption+':'+#9,Edit1.Text,' '+Label8.Caption);
    writeln(f,' '+Label9.Caption+':'+#9,Edit2.Text,' '+Label10.Caption);
    writeln(f,' '+Label11.Caption+':'+#9,Edit3.Text,' '+Label12.Caption);
    writeln(f,' '+Label13.Caption+':'+#9,Edit4.Text,' '+Label18.Caption);
    writeln(f,'');
    writeln(f,'('+Form1.Caption+')');
    writeln(f,'');
    closefile(f);
  except
    MessageDlg(MESSAGE06,mtError,[mbOk],0);
    saved:=false;
    exit;
  end;
  saved:=true;
end;

// other events
procedure TForm1.FloatSpinEdit1Change(Sender: TObject);
begin
  saved:=false;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if saved=true then Application.Terminate else
    if MessageDlg(MESSAGE07,mtConfirmation, [mbYes, mbNo],0)=mrNo
    then exit
    else Button4Click(Sender);
  if saved=true then Application.Terminate else CanClose:=false;
end;

// OnCreate event
procedure TForm1.FormCreate(Sender: TObject);
begin
  saved:=true;
  Form1.Caption:=APPNAME+' v'+VERSION;

 {$IFDEF WIN32}
  fsplit(paramstr(0),exepath,p,p);
 {$ENDIF}

 {$IFDEF UNIX}
  userdir:=getenvironmentvariable('HOME');
 {$ENDIF}
 {$IFDEF WIN32}
  userdir:=getuserprofile;
 {$ENDIF}

 {$IFDEF UNIX}
  s:=getenv('LANG');
 {$ENDIF}
 {$IFDEF WIN32}
  Size:=GetLocaleInfo (LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, nil, 0);
  GetMem(Buffer, Size);
  try
    GetLocaleInfo (LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, Buffer, Size);
    s:=string(Buffer);
  finally
    FreeMem(Buffer);
  end;
 {$ENDIF}
  if length(s)=0 then s:='en';
  lang:=lowercase(s[1..2]);
 {$IFDEF UNIX}{$IFDEF UseFHS}
  translateresourcestrings(MYI18PATH+LANG+'/LC_MESSAGES/chc.mo');
 {$ELSE}
  translateresourcestrings(EXEPATH+'languages/'+LANG+'/chc_'+LANG+'.mo');
 {$ENDIF}{$ENDIF}
 {$IFDEF WIN32}
  translateresourcestrings(EXEPATH+'languages\'+LANG+'\chc_'+LANG+'.mo');
 {$ENDIF}

  Button2Click(Sender);
end;

end.
