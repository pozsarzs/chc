{ +--------------------------------------------------------------------------+ }
{ | CHC v0.2 * Chocking coil sizing application                              | }
{ | Copyright (C) 2012-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | chc.lpr                                                                  | }
{ | Project file.                                                            | }
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

program chc;
{$MODE OBJFPC}{$H+}
uses
  Dialogs, Interfaces, Forms, SysUtils,
 {$IFDEF UseFHS} unttranslator, {$ELSE} DefaultTranslator,{$ENDIF}
  crt,  frmmain, frmabout;
var
  b: byte;
  appmode: byte;
  fn: string;
const
  params: array[1..2,1..3] of string=
  (
    ('-h','--help','show help'),
    ('-v','--version','show version and build information')
  );

{$R *.res}

procedure help(mode: boolean);
var
  b: byte;
begin
  if mode then
    showmessage('There are one or more bad parameters in command line.') else
    begin
     {$IFDEF UNIX} 
      writeln('Usage:');
      writeln(' ',fn,{$IFDEF WIN32}'.',fe,{$ENDIF}' [parameter]');
      writeln;
      writeln('parameters:');
      for b:=1 to 4 do
      begin
        write('  ',params[b,1]);
        gotoxy(8,wherey); write(params[b,2]);
        gotoxy(30,wherey); writeln(params[b,3]);
      end;
      writeln;
     {$ENDIF}
     {$IFDEF WIN32}
      s:='Usage:'+#13+#10;
      s:=s+' '+fn+' [parameter]'+#13+#10+#13+#10;
      s:=s+'parameters:';
      for b:=1 to 2 do
        s:=s+#13+#10+'  '+params[b,1]+', '+params[b,2]+': '+params[b,3];
      showmessage(s);
     {$ENDIF}
    end;
  halt(0);
end;

procedure verinfo;
begin
 {$IFDEF UNIX}
  writeln(frmmain.APPNAME+' v'+frmmain.VERSION);
  writeln;
  writeln('This application was compiled at ',{$I %TIME%},' on ',{$I %DATE%},' by ',{$I %USER%});
  writeln('FPC version: ',{$I %FPCVERSION%});
  writeln('Target OS:   ',{$I %FPCTARGETOS%});
  writeln('Target CPU:  ',{$I %FPCTARGETCPU%});
 {$ENDIF}
 {$IFDEF WIN32}    
  s:=frmmain.APPNAME+' v'+frmmain.VERSION+#13+#10+#13+#10;
  s:=s+'This was compiled at '+{$I %TIME%}+' on '+{$I %DATE%}+' by '+{$I %USERNAME%}+'.'+#13+#10+#13+#10;
  s:=s+'FPC version: '+{$I %FPCVERSION%}+#13+#10;
  s:=s+'Target OS:   '+{$I %FPCTARGETOS%}+#13+#10;
  s:=s+'Target CPU:  '+{$I %FPCTARGETCPU%};
  showmessage(s);
 {$ENDIF}
  halt(0);
end;

begin
  fn:=extractfilename(paramstr(0));
  appmode:=0;
  if length(paramstr(1))=0 then appmode:=1 else
  begin
    for b:=1 to 2 do
      if paramstr(1)=params[b,1] then appmode:=10*b;
    for b:=1 to 2 do
      if paramstr(1)=params[b,2] then appmode:=10*b;
  end;
  case appmode of
     0: help(true);
    10: help(false);
    20: verinfo;
  end;
  Application.Title:='CHC';
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

