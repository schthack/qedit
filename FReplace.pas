unit FReplace;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, TextEditor.Types;

type
  TfmReplace = class(TForm)
    Edit1: TEdit;
    btnOK: TButton;
    chkMatchCase: TCheckBox;
    btnClose: TButton;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    chkSelection: TCheckBox;
    procedure btnOKClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
    Replace.SetOption(TTextEditorReplaceOption.roCaseSensitive,chkMatchCase.Checked);
    Replace.SetOption(TTextEditorReplaceOption.roSelectedOnly,chkSelection.Checked);
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

end.
