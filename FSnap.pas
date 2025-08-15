unit FSnap;

interface

uses
  Winapi.Windows, Registry, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TFSnapOptions = class(TForm)
    btnSave: TButton;
    chkDistancelimit: TCheckBox;
    seDistanceLimit: TSpinEdit;
    chkSnapDistance: TCheckBox;
    chkSnapRotate: TCheckBox;
    btnReset: TButton;
    seSnapTolerance: TSpinEdit;
    Label8: TLabel;
    chkSnap: TCheckBox;
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure chkDistancelimitClick(Sender: TObject);
    procedure chkSnapClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSnapOptions: TFSnapOptions;

implementation

{$R *.dfm}


procedure TFSnapOptions.btnResetClick(Sender: TObject);
begin
  chkSnap.Checked := false;
  seSnapTolerance.Value := 10;
  seDistanceLimit.Value := 30;
  seDistanceLimit.Enabled := false;
  chkDistanceLimit.Checked := false;
  chkSnapRotate.Checked := false;
  chkSnapDistance.Checked := false;
end;

procedure TFSnapOptions.btnSaveClick(Sender: TObject);
var Reg: TRegistry;
begin
  // Save all snap values to the registry
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
    begin
      Reg.WriteInteger('SnapValue', seSnapTolerance.Value);
      Reg.WriteInteger('DistanceLimit', seDistanceLimit.Value);
      Reg.WriteBool('SnapRotate', chkSnapRotate.Checked);
      Reg.WriteBool('SnapDistance', chkSnapDistance.Checked);
      Reg.WriteBool('AnchorEnabled', chkDistanceLimit.Checked);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
    close;
end;

procedure TFSnapOptions.chkDistancelimitClick(Sender: TObject);
begin
  if chkSnap.Checked then
    seDistanceLimit.Enabled := chkDistanceLimit.Checked;
end;

procedure TFSnapOptions.chkSnapClick(Sender: TObject);
var
  Reg: TRegistry;
begin
  chkSnapDistance.Enabled := chkSnap.Checked;
  chkSnapRotate.Enabled := chkSnap.Checked;
  chkDistanceLimit.Enabled := chkSnap.Checked;
  seSnapTolerance.Enabled := chkSnap.Checked;
  if chkDistanceLimit.Checked then
    seDistanceLimit.Enabled := chkSnap.Checked;

  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
  begin
    Reg.WriteBool('SnapEnabled', chkSnap.Checked);
    Reg.CloseKey;
  end;
  finally
    Reg.Free;
  end;
end;

procedure TFSnapOptions.FormCreate(Sender: TObject);
begin
  seSnapTolerance.MinValue := 0;
  seSnapTolerance.MaxValue := High(integer);
  seDistanceLimit.MinValue := 0;
  seDistanceLimit.MaxValue := High (integer);
end;

end.
