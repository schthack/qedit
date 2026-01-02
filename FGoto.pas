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
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmGoto: TfmGoto;

implementation

uses FScriptTE, main;

{$R *.dfm}

procedure TfmGoto.btnOKClick(Sender: TObject);
var
  i: integer;
  labelfound: Boolean;
begin
  if Caption = GetLanguageString(381) then
  begin
    fmScriptTE.TextEdit.GoToLineAndSetPosition(SpinEdit1.Value,
    length(fmScriptTE.TextEdit.Lines[SpinEdit1.Value]) + 1);
    Close
  end
  else
  begin
    labelfound := false;

    with fmScriptTE.TextEdit do
    begin
      for i := 0 to Lines.Count - 1 do
      begin
        if Lines[i].StartsWith(SpinEdit1.Text + ':') then
        begin
          labelfound := true;
          // Move caret to end of line
          GoToLineAndSetPosition(i,length(Lines[i]) + 1);
          break;
        end;
      end;
    end;

    if not labelfound then
      MessageDlg(GetLanguageString(447), mtInformation,[mbOk], 0)
    else fmGoto.Close;
  end;
end;

procedure TfmGoto.Button1Click(Sender: TObject);
begin
  fmGoto.Close;
end;

procedure TfmGoto.FormShow(Sender: TObject);
begin
    // Center form based on the text editor position
    fmGoto.Left := fmScriptTE.Left + (fmScriptTE.Width - fmGoto.Width) div 2;
    fmGoto.Top := fmScriptTE.Top + (fmScriptTE.Height - fmGoto.Height) div 2;
end;

end.
