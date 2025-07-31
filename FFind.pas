unit FFind;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, TextEditor.Types;

type
  TfmFind = class(TForm)
    Edit1: TEdit;
    btnOK: TButton;
    chkMatchCase: TCheckBox;
    btnClose: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmFind: TfmFind;

implementation

uses FScriptTE;

{$R *.dfm}

procedure TfmFind.btnCloseClick(Sender: TObject);
begin
  fmFind.Close;
end;

procedure TfmFind.btnOKClick(Sender: TObject);
begin
  with fmScriptTE.TextEdit.Search do
  begin
    SearchText := Edit1.Text;
    SetOption(TTextEditorSearchOption.soCaseSensitive,chkMatchCase.Checked);
    Execute;
    ClearItems;
    SearchText := '';
  end;
end;

procedure TfmFind.FormShow(Sender: TObject);
begin
  // Center form based on the text editor position
  fmFind.Left := fmScriptTE.Left + (fmScriptTE.Width - fmFind.Width) div 2;
  fmFind.Top := fmScriptTE.Top + (fmScriptTE.Height - fmFind.Height) div 2;
end;

end.
