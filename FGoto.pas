unit FGoto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, TextEditor.Types;

type
  TfmGoto = class(TForm)
    btnOK: TButton;
    SpinEdit1: TSpinEdit;
    Button1: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmGoto: TfmGoto;

implementation

uses FScriptTE;

{$R *.dfm}

procedure TfmGoto.btnOKClick(Sender: TObject);
begin
  fmScriptTE.TextEdit.MoveCaretToBeginning;
  with fmScriptTE.TextEdit.Search do
  begin
    SearchText := SpinEdit1.Text + ':    ';
    SetOption(TTextEditorSearchOption.soBeepIfStringNotFound, false);
    Execute;
    SetOption(TTextEditorSearchOption.soBeepIfStringNotFound, true);
    fmScriptTE.TextEdit.Search.ClearItems;
    fmScriptTE.TextEdit.search.SearchText := '';
  end;
  fmGoto.Close;
end;

procedure TfmGoto.Button1Click(Sender: TObject);
begin
  fmGoto.Close;
end;

end.
