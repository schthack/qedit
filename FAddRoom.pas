unit FAddRoom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TfmRoom = class(TForm)
    btnOK: TButton;
    SpinEdit1: TSpinEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRoom: TfmRoom;

implementation

{$R *.dfm}

uses main, unit15;

procedure TfmRoom.btnOKClick(Sender: TObject);
var
  idx, x: Integer;
begin
  if fmRoom.Caption = GetLanguageString(317) then
  begin
    SetLength(roomdata, Length(roomdata) + 1);
    idx := High(roomdata);
    with roomdata[idx] do
    begin
      roomnum := Spinedit1.Value;
      numentries := 0;
      SetLength(data, 0);
    end;
    Close;
  end
  else if fmRoom.Caption = GetLanguageString(318) then
  begin
    idx := form15.ListBox1.ItemIndex;

    // Update the roomnum in the roomdata array
    roomdata[idx + 1].roomnum := Spinedit1.Value;

    // Update the room ID cell
    if roomdata[idx + 1].numentries > 0 then
    begin
      for x := 0 to roomdata[idx + 1].numentries do
        move(roomdata[idx + 1].roomnum, roomdata[idx + 1].data[(x * 28) + 24], 2);
    end;
    Close;
  end;

  // Save and reload the data
  form15.SaveD04;
  form15.LoadRandomData;
  form15.ListBox1Click(nil);
end;

procedure TfmRoom.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfmRoom.FormShow(Sender: TObject);
begin
  SpinEdit1.SetFocus;
  SpinEdit1.SelectAll;
end;

end.
