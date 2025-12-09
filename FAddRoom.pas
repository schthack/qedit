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

uses unit15;

procedure TfmRoom.btnOKClick(Sender: TObject);
var
  idx: Integer;
begin
  if fmRoom.Caption = 'Add room' then
  begin
    SetLength(roomdata, Length(roomdata) + 1);
    idx := High(roomdata);
    with roomdata[idx] do
    begin
      roomnum := Spinedit1.Value;
      numentries := 0;
      SetLength(data, 0);
    end;

    form15.ListBox1.Items.Add(IntToStr(Spinedit1.Value) + ' (0 entries)');
    form15.ListBox1.ItemIndex := form15.ListBox1.Count - 1;
    form15.ListBox1Click(nil);
    Close;
  end
  else if fmRoom.Caption = 'Edit room' then
  begin
    idx := form15.ListBox1.ItemIndex;

    // Update the roomnum in the roomdata array
    roomdata[idx + 1].roomnum := Spinedit1.Value;

    // Update the ListBox display
    form15.ListBox1.Items[idx] := IntToStr(Spinedit1.Value) +
      ' (' + IntToStr(roomdata[idx + 1].numentries) + ' entries)';
    Close;
  end;
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
