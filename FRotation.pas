unit FRotation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TfmRotation = class(TForm)
    btnOK: TButton;
    SpinEdit1: TSpinEdit;
    btnCancel: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRotation: TfmRotation;

implementation

{$R *.dfm}

procedure TfmRotation.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmRotation.btnOKClick(Sender: TObject);
begin
  modalresult := 1;
end;

end.
