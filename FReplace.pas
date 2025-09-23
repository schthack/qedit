unit FReplace;

interface

uses
  Winapi.Windows, Winapi.Messages, Registry, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, TextEditor.Types;

type
  TfmReplace = class(TForm)
    Edit1: TEdit;
    btnOK: TButton;
    btnClose: TButton;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Selectiononly1: TCheckBox;
    procedure btnOKClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Selectiononly1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmReplace: TfmReplace;

implementation

uses FScriptTE;

{$R *.dfm}

procedure TfmReplace.btnCloseClick(Sender: TObject);
begin
  fmReplace.Close;
end;

procedure TfmReplace.btnOKClick(Sender: TObject);
begin
  with fmScriptTE.TextEdit do
  begin
    Replace.SetOption(TTextEditorReplaceOption.roCaseSensitive,fmScriptTE.Matchcase1.Checked);
    if Selectiononly1.Checked then
      Replace.SetOption(TTextEditorReplaceOption.roEntireScope,false)
    else
      Replace.SetOption(TTextEditorReplaceOption.roEntireScope,true);
    Replace.SetOption(TTextEditorReplaceOption.roSelectedOnly,Selectiononly1.Checked);
    ReplaceText(Edit1.Text,Edit2.Text,false);
  end;

 fmReplace.Close;
end;

procedure TfmReplace.FormShow(Sender: TObject);
begin
    // Center form based on the text editor position
    fmReplace.Left := fmScriptTE.Left + (fmScriptTE.Width - fmReplace.Width) div 2;
    fmReplace.Top := fmScriptTE.Top + (fmScriptTE.Height - fmReplace.Height) div 2;
end;

procedure TfmReplace.Selectiononly1Click(Sender: TObject);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
  begin
    Reg.WriteBool('ReplaceSelectionOnly', Selectiononly1.Checked);
    Reg.CloseKey;
  end;
  finally
    Reg.Free;
  end;
end;

end.
