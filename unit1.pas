unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButBackspace: TButton;
    But4: TButton;
    But5: TButton;
    But6: TButton;
    ButMul: TButton;
    ButInv: TButton;
    But1: TButton;
    But2: TButton;
    But3: TButton;
    ButSub: TButton;
    But0: TButton;
    ButClearEntity: TButton;
    ButDec: TButton;
    ButAdd: TButton;
    ButEquals: TButton;
    ButClear: TButton;
    ButSqrt: TButton;
    But7: TButton;
    But8: TButton;
    But9: TButton;
    ButDiv: TButton;
    ButSqr: TButton;
    EditResult: TEdit;

    procedure ButDigitClick(Sender: TObject);
    procedure ButDecClick(Sender: TObject);
    procedure ButOperatorClick(Sender: TObject);
    procedure ButEqualsClick(Sender: TObject);
    procedure ButClearClick(Sender: TObject);
    procedure ButClearEntryClick(Sender: TObject);
    procedure ButBackspaceClick(Sender: TObject);
    procedure ButSqrtClick(Sender: TObject);
    procedure ButSqrClick(Sender: TObject);
    procedure ButInvClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
   FirstNumber: Double;
   CurrentOperator: Char;
   NewInput: Boolean;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  EditResult.ReadOnly := True;
  EditResult.Text := '0';
  EditResult.Alignment := taRightJustify;
  EditResult.TabOrder := 0;

  FirstNumber := 0;
  CurrentOperator := #0;
  NewInput := True;

  Scaled := False;
  BorderStyle := bsSingle;
end;

procedure TForm1.ButDigitClick(Sender: TObject);
begin
  if NewInput or (EditResult.Text = '0') then
  begin
    EditResult.Text := (Sender as TButton).Caption;
    NewInput := False;
  end
  else
    EditResult.Text := EditResult.Text + (Sender as TButton).Caption;
end;

procedure TForm1.ButDecClick(Sender: TObject);
begin
  if NewInput then
  begin
    EditResult.Text := '0,';
    NewInput := False;
  end
  else if Pos(',', EditResult.Text) = 0 then
    EditResult.Text := EditResult.Text + ',';
end;

procedure TForm1.ButOperatorClick(Sender: TObject);
var
  Value: Double;
begin
  if not TryStrToFloat(EditResult.Text, Value) then
  begin
    ShowMessage('Ошибка ввода числа');
    Exit;
  end;

  FirstNumber := Value;
  CurrentOperator := (Sender as TButton).Caption[1];
  NewInput := True;
end;

procedure TForm1.ButEqualsClick(Sender: TObject);
var
  SecondNumber: Double;
  ResultValue: Double;
begin
  if CurrentOperator = #0 then
    Exit;

  if not TryStrToFloat(EditResult.Text, SecondNumber) then
  begin
    ShowMessage('Ошибка ввода числа');
    Exit;
  end;

  case CurrentOperator of
    '+': ResultValue := FirstNumber + SecondNumber;
    '-': ResultValue := FirstNumber - SecondNumber;
    '*': ResultValue := FirstNumber * SecondNumber;
    '/':
      begin
        if SecondNumber = 0 then
        begin
          ShowMessage('Деление на ноль невозможно');
          EditResult.Text := '0';
          NewInput := True;
          Exit;
        end;

        ResultValue := FirstNumber / SecondNumber;
      end;
  else
    Exit;
  end;

  EditResult.Text := FloatToStr(ResultValue);
  CurrentOperator := #0;
  NewInput := True;
end;

procedure TForm1.ButClearClick(Sender: TObject);
begin
  EditResult.Text := '0';
  FirstNumber := 0;
  CurrentOperator := #0;
  NewInput := True;
end;

procedure TForm1.ButClearEntryClick(Sender: TObject);
begin
  EditResult.Text := '0';
  NewInput := True;
end;

procedure TForm1.ButBackspaceClick(Sender: TObject);
var
  S: String;
begin
  S := EditResult.Text;

  if Length(S) > 1 then
  begin
    Delete(S, Length(S), 1);
    EditResult.Text := S;
  end
  else
    EditResult.Text := '0';
end;

procedure TForm1.ButSqrtClick(Sender: TObject);
var
  Value: Double;
begin
  if not TryStrToFloat(EditResult.Text, Value) then
  begin
    ShowMessage('Ошибка ввода числа');
    Exit;
  end;

  if Value < 0 then
  begin
    ShowMessage('Нельзя извлечь корень из отрицательного числа');
    Exit;
  end;

  EditResult.Text := FloatToStr(Sqrt(Value));
  NewInput := True;
end;

procedure TForm1.ButSqrClick(Sender: TObject);
var
  Value: Double;
begin
  if not TryStrToFloat(EditResult.Text, Value) then
  begin
    ShowMessage('Ошибка ввода числа');
    Exit;
  end;

  EditResult.Text := FloatToStr(Value * Value);
  NewInput := True;
end;

procedure TForm1.ButInvClick(Sender: TObject);
var
  Value: Double;
begin
  if not TryStrToFloat(EditResult.Text, Value) then
  begin
    ShowMessage('Ошибка ввода числа');
    Exit;
  end;

  if Value = 0 then
  begin
    ShowMessage('Деление на ноль невозможно');
    Exit;
  end;

  EditResult.Text := FloatToStr(1 / Value);
  NewInput := True;
end;

end.

