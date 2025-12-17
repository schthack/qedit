unit FThemes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Themes, Vcl.Styles;

type
  TfmThemes = class(TForm)
    ComboBox1: TComboBox;
    btnCancel: TButton;
    btnOK: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmThemes: TfmThemes;

implementation

{$R *.dfm}

procedure TfmThemes.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmThemes.btnOKClick(Sender: TObject);
begin
  modalresult := 1;
end;

procedure TfmThemes.ComboBox1Change(Sender: TObject);
begin
  fmThemes.StyleName := ComboBox1.Items[ComboBox1.ItemIndex];
end;

procedure TfmThemes.FormCreate(Sender: TObject);
var
  StyleName: string;
begin
  ComboBox1.Items.BeginUpdate;
  try
    ComboBox1.Items.Clear;

    for StyleName in TStyleManager.StyleNames do
      ComboBox1.Items.Add(StyleName);

    // Select current style
    ComboBox1.ItemIndex :=
    ComboBox1.Items.IndexOf(TStyleManager.ActiveStyle.Name);

    ComboBox1.Items[29] := 'Windows (Default)';
  finally
    ComboBox1.Items.EndUpdate;
  end;
end;

end.
