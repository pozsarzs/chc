{ +--------------------------------------------------------------------------+ }
{ | CHC v0.2 * Choking coil sizing application                               | }
{ | Copyright (C) 2012-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmabout.pas                                                             | }
{ | About                                                                    | }
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

unit frmabout;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, process, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Buttons;
type
  { TForm2 }
  TForm2 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Process1: TProcess;
    Process2: TProcess;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label6MouseEnter(Sender: TObject);
    procedure Label6MouseLeave(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label8MouseEnter(Sender: TObject);
    procedure Label8MouseLeave(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  Form2: TForm2;
const
  {$IFDEF UNIX}
    BROWSER='xdg-open';
    MAILER='xdg-email';
  {$ENDIF}
  {$IFDEF WINDOWS}
    BROWSER='rundll32.exe url.dll,FileProtocolHandler';
    MAILER='rundll32.exe url.dll,FileProtocolHandler mailto:';
  {$ENDIF}
  EMAIL='pozsarzs@gmail.com';
  WEB='http://www.pozsarzs.hu';

Resourcestring
  MESSAGE01='Cannot run default browser.';
  MESSAGE02='Cannot run default mailer.';

procedure runbrowser(url: string);

implementation
uses frmmain;
{$R *.lfm}
{ TForm2 }

// run browser
procedure runbrowser(url: string);
begin
  Form2.Process1.Executable:=BROWSER;
  Form2.Process1.Parameters.Add(url);
  try
    Form2.Process1.Execute;
  except
    ShowMessage(MESSAGE01);
  end;
end;

// run mailer
procedure runmailer(url: string);
begin
  Form2.Process2.Executable:=MAILER;
  Form2.Process2.Parameters.Add(url);
  try
    Form2.Process2.Execute;
  except
    ShowMessage(MESSAGE02);
  end;
end;

// close about
procedure TForm2.Button1Click(Sender: TObject);
begin
  Form2.Close;
end;

// open default browser
procedure TForm2.Label6Click(Sender: TObject);
begin
  runbrowser(Label6.Caption);
end;

// open default mailer
procedure TForm2.Label8Click(Sender: TObject);
begin
  runmailer(Label8.Caption);
end;

// other events
procedure TForm2.Label6MouseEnter(Sender: TObject);
begin
   Label6.Font.Color:=clRed;
   Label6.Font.Style:=[fsUnderline];
end;

procedure TForm2.Label6MouseLeave(Sender: TObject);
begin
  Label6.Font.Color:=clBlue;
  Label6.Font.Style:=[];
end;

procedure TForm2.Label8MouseEnter(Sender: TObject);
begin
  Label8.Font.Color:=clRed;
  Label8.Font.Style:=[fsUnderline];
end;

procedure TForm2.Label8MouseLeave(Sender: TObject);
begin
  Label8.Font.Color:=clBlue;
  Label8.Font.Style:=[];
end;

// OnCreate event
procedure TForm2.FormCreate(Sender: TObject);
begin
  Label1.Caption:=frmmain.APPNAME+' v'+frmmain.VERSION;
  Label6.Caption:=WEB;
  Label8.Caption:=EMAIL;
end;

end.
