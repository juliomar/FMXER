unit Frames.ActionButton;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Ani, FMX.Layouts, SubjectStand,
  FrameStand, Frames.Text;

type
  TActionButtonFrame = class(TFrame)
    BackgroundCircle: TCircle;
    OverlayLayout: TLayout;
    FrameStand1: TFrameStand;
    ClickableLayout: TLayout;
    procedure ClickableLayoutClick(Sender: TObject);
  private
    FOnClickProc: TProc;
    FOverlayStand: string;
  protected
    FOverlay: TSubjectInfo;
  public
    constructor Create(AOwner: TComponent); override;

    procedure SetOverlayAsFrame<T: TFrame>(const AConfigProc: TProc<T> = nil);
//    procedure SetOverlayAsForm<T: TForm>(const AConfigProc: TProc<T> = nil);

    // shortcuts
    procedure SetOverlayAsText(const AText: string; const AConfigProc: TProc<TTextFrame> = nil);

    property OnClickProc: TProc read FOnClickProc write FOnClickProc;
    property OverlayStand: string read FOverlayStand write FOverlayStand;
  end;

implementation

{$R *.fmx}

uses UI.Consts;

{ TActionButtonFrame }

procedure TActionButtonFrame.ClickableLayoutClick(Sender: TObject);
begin
  if Assigned(FOnClickProc) then
    FOnClickProc();
end;

constructor TActionButtonFrame.Create(AOwner: TComponent);
begin
  inherited;
  BackgroundCircle.Fill.Color := TAppColors.PRIMARY_COLOR;
end;

procedure TActionButtonFrame.SetOverlayAsFrame<T>(
  const AConfigProc: TProc<T>);
begin
  FOverlay := FrameStand1.NewAndShow<T>(OverlayLayout, OverlayStand, AConfigProc);
end;

procedure TActionButtonFrame.SetOverlayAsText(const AText: string;
  const AConfigProc: TProc<TTextFrame>);
begin
  SetOverlayAsFrame<TTextFrame>(
    procedure (ATextFrame: TTextFrame)
    begin
      ATextFrame.Content := AText;
      if Assigned(AConfigProc) then
        AConfigProc(ATextFrame);
    end
  );
end;

end.