﻿unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.OleCtrls, SHDocVw, ExprDraw, ExprMake;
  {For My lines}


type TrigomonetricAndExp = (sin, cos, tg ,ctg, arcsin, arccos, arctg, arcctg, exp, ln);
type PoworLogrRoot =  (power, log, root,del);

type Element = record
data: string;
UpLine : array of element;
lenOfUpLine: integer;
DownLine: array of element;
lenOfDownLine: integer;
curElOfLine: integer;
TypeOfFunc : integer;      //0- число/+/-/*, 1-"одноэтажная" функция, 2-двухэтажная функция

whichTrigFunc: TrigomonetricAndExp;

whichTwoArgFunc: PoworLogrRoot;
deep : integer;
prevDeepLevel: ^Element;
end;


    {End of For My lines}

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    Panel2: TPanel;
    Button2: TButton;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Button3: TButton;
    Panel3: TPanel;
    Button5: TButton;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label6: TLabel;
    Label5: TLabel;
    Enter1: TButton;
    Enter2: TButton;
    Enter3: TButton;
    Enter4: TButton;
    Enter5: TButton;
    Enter6: TButton;
    Enter7: TButton;
    Enter8: TButton;
    Enter9: TButton;
    Enter0: TButton;
    EnterPlus: TButton;
    EnterMinus: TButton;
    EnterMult: TButton;
    EnterDel: TButton;
    EnterStep: TButton;
    Enterexp: TButton;
    Enterlog: TButton;
    EnterLn: TButton;
    Entersin: TButton;
    Entercos: TButton;
    Entertg: TButton;
    EnterCtg: TButton;
    Enterarctg: TButton;
    EnterArccos: TButton;
    EnterArcsin: TButton;
    EnterArcctg: TButton;
    EntBackspace: TButton;
    NextEl: TButton;
    Button33: TButton;
    Button34: TButton;
    EnterX: TButton;
    EnterRoot: TButton;
    Button35: TButton;
    Edit1: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Panel4: TPanel;
    Label9: TLabel;
    Button4: TButton;
    Button6: TButton;
    Button7: TButton;
    Memo1: TMemo;
    Button8: TButton;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

    procedure Button5Click(Sender: TObject);
    procedure Enter1Click(Sender: TObject);
    procedure EnterPlusClick(Sender: TObject);
    procedure Enter2Click(Sender: TObject);
    procedure Enter3Click(Sender: TObject);
    procedure Enter4Click(Sender: TObject);
    procedure Enter5Click(Sender: TObject);
    procedure Enter6Click(Sender: TObject);
    procedure Enter7Click(Sender: TObject);
    procedure Enter8Click(Sender: TObject);
    procedure Enter9Click(Sender: TObject);
    procedure Enter0Click(Sender: TObject);
    procedure EnterMinusClick(Sender: TObject);
    procedure EnterMultClick(Sender: TObject);
    procedure EnterLnClick(Sender: TObject);
    procedure EnterXClick(Sender: TObject);
    procedure EnterexpClick(Sender: TObject);
    procedure EntersinClick(Sender: TObject);
    procedure EntercosClick(Sender: TObject);
    procedure EntertgClick(Sender: TObject);
    procedure EnterCtgClick(Sender: TObject);
    procedure EnterArcsinClick(Sender: TObject);
    procedure EnterArccosClick(Sender: TObject);
    procedure EnterarctgClick(Sender: TObject);
    procedure EnterArcctgClick(Sender: TObject);
    procedure EnterRootClick(Sender: TObject);
    procedure EnterlogClick(Sender: TObject);
    procedure EnterStepClick(Sender: TObject);
    procedure NextElClick(Sender: TObject);
    procedure EnterDelClick(Sender: TObject);
    procedure EntBackspaceClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    {work with inputLine}


  private
    { Private declarations }
  public
    { Public declarations }
    var taskString, correctAnswer: string;
      wasThisTask: array of integer;

     numOfTask, numOfAnswers, numOfCorrectAnswers: integer;
    thisEl: ^string;

  end;

var
  Form1: TForm1;
  inpLine: array of Element;
  thisLev : ^Element;
  lenOfArr: integer;
  currentElement: integer;
  curDeep : integer;
  AnswerFormula, AnswerFormulaShow: TExprClass;
  user_answer: string;
  const thirdRuleSimp : array[0..29] of array[0..1] of string =(
  ('(3*x+2)/(4-x)','(14)/((4-x)^(2))'),
  ('(4*x-1)/(x)','(1)/((x)^(2))'),  //изменено, было ('(1-4*x)/(x)','(-1)*x')
  ('(x^2-3)/(1+x)','((x)^(2)+2*x+3)/((1+x)^(2))'),
  ('(x^2)/(3-4*x)','(6*x-4*(x)^(2))/((3-4*x)^(2))'),
  ('(x^2)/(5*x-8)','(5*(x)^(2)-16*x)/((5x-8)^(2))'),
  ('(sin(x))/(2*x+1)','(cos(x)*2*x+cos(x)-2*sin(x))/((2*x+1)^(2))'),
  ('(6*x+5)/(4-3*x)','(39)/((4-3*x)^(2))'),
  ('(3*x-7)/(5-2*x)','(1)/((5-2*x)^(2))'),
  ('(1+3*x)/(1-3*x)','(6)/((1-3*x)^(2))'),//изменено, было'(1-3*x)/(1+3*x)','(-6)/((1+3*x)^(2))'),
  ('(sin(x))/(x)','(cos(x)*x-sin(x))/((x)^(2))'),
  ('(x^2)/(Pow(e,x))','(2*x-(x)^(2))/(exp(x))'),
  ('((x)^(2))/(sin(x))','(2*x*sin(x)-(x)^(2)*cos(x))/((sin(x))^(2))'),
  ('((x)^(5))/(ln(x))','(5*(x)^(4)*ln(x)-(x)^(4))/((ln(x))^(2))'),
  ('(-1)/(1+(x)^(2))','(2x)/((1+(x)^(2))^(2))'),   //изменено, в условии добавлен минус, поменяялся только знак  ответа
  ('(Pow(e,x))/(sin(x))','(exp(x)*sin(x)-exp(x)*cos(x))/((sin(x))^(2))'),
  ('(-cos(x))/((2)^(x))','((sin(x)+cos(x)*ln(2))/((2)^(x))'),   //изменено, в условии добавлен - кроме знака ничего не поменялосб
  ('(ln(x))/((3)^(x))','(1-ln(3)*x*ln(x))/(x*(3)^(x))'),
  ('(tg(x))/((5)^(x))','(1-ln(5)*cos(x)*sin(x))/((cos(x))^(2)*(5)^(x))'),
  ('(sin(x))/((7)^(x))','(cos(x)-ln(7)*sin(x))/((7)^(x))'),
  ('(Pow(e,x))/(cos(x))','(exp(x)*cos(x)+exp(x)*sin(x)/((cos(x))^(2))'),
  ('(arcsin(x))/(1-(x)^(2))','((2)root(1-(x)^(2))+2*arcsin(x)*x)/((1-(x)^(2))^(2))'),
  ('(-ctg(x))/((6)^(x))','(1+ln(6)*sin(x)*cos(x))/((sin(x))^(2)*(6)^(x))'),   //изменено, добавлен минус
  ('(Sqrt(x))/(cos(x))','(cos(x)+2*x*sin(x))/(2*(2)root(x)*(cos(x))^(2))'),
  ('(1+tg(x))/((4)^(x))','(1-ln(4)*((cos(x))^(2)+ln(4)*cos(x)*sin(x))((cos(x))^(2)*(4)^(x))'),
  ('((5)^(x))/(Pow(e,x))','(ln(5)*(5)^(x)-(5)^(x))/(exp(x))'),
  ('(2+ln(x))/(3-cos(x))','(3-cos(x)-2*x*sin(x)-x*ln(x)*sin(x))/(x*(3-cos(x))^(2))'),
  ('((5)^(x))/(sin(x))','(ln(5)*(5)^(x)*sin(x)-(5)^(x)*cos(x))/((sin(x))^(2))'),
  ('(sin(x))/(Pow(e,x))','(cos(x)-sin(x))/(exp(x))'),
  ('(ln(x))/(cos(x))','(cos(x)+x*ln(x)*sin(x))/(x*(cos(x))^(2))'),
  ('(ln(x))/(Sqrt(x))','(2-ln(x))/(2*x*(2)root(x))'));
  const thirdRuleHard : array[0..2] of array[0..1] of string =(
  ('(6*x-4*(x)^(2))/((3-4*x)^(2))','(18)/((3-4*x)^(3))'),
  ('(1)/(cos(x))','(tg(x))/(cos(x))'),
  ('(2*(x)^(3)+7*(x)^(2)-3*x-5)/((x)^(2))', '2+ (3)/((x)^(2))+(10)/((x)^(3))'));
  const difHardFuncSimp: array[0..20] of array[0..1] of string =(
  ('(x^2+1)^3', '6*((x)^(2)+1)^(2)*x'),
  ('(3*(x)^(4)-2*(x)^(2)+1)^(5)','60*(x)^(3)*(3*(x)^(4)-2*(x)^(2)+1)^(4)-20*x*(3*(x)^(4)-2*(x)^(2)+1)^(4)'),
  //('(2*(x)^(5)+3*(x)^(3)-4*x)^(4)', ''),убрал в связи с тем, что без скобок будет очень длинное выражение
   ('(x^3+2)^8', '24*(x)^(2)*((x)^(3)+2)^(7))'),
    ('8*(6*x-5)^(5/8)', '(30)/((8)root((6*x-5)^(3))'),
    ('4*(2*(x)^(3)+7)^(11)', '264*(x)^(2)*(2*(x)^(3)+7)^(10)'),
    ('Pow(e,5*x)','5*exp(5*x)'),
    ('Pow(e,sin(x))', 'exp(sin(x))*cos(x)'),
    ('(2)^(5*x))', '5*ln(2)*(32)^(x)'),
    ('(2)^(sin(x))', 'ln(2)*(2)^(sin(x))*cos(x)'),
    ('-(4)^(cos(x))', 'ln(4)*(4)^(cos(x))*sin(x)'),//изменен знак вначале
    ('Sqrt(Pow(e,x)+2*x)', '(exp(x)+2)/(2*(2)root(exp(x)+2*x))'),
    ('sin(5*x)', '5*cos(x)'),
    ('-cos(5*x)', 'sin(x)'),  //убрал пи, добавил -
    ('tg(8*x))', '(8)/((cos(8*x))^2)'),
    ('-ctg(2*x)', '(2)/((sin(2*x))^(2))'),//добавил -
    ('-ln(4-5*x)', '(5)/(4-5*x)'),//добавил минус
    ('-(1/5)^(-3*x-1)', '3*ln(5)*(5)^(3*x+1)'),//изменено,- в показателе, перевел из десятичной в обыкновенную
    ('-ln(cos(x))', 'tg(x)'),
    ('-(1/2)^(4*x+2)', '(ln(2))/((16)^(x))'), //добавил -
    ('Sqrt(3*(x)^(2)+1)', '(3*x)/((2)root(3*(x)^(2)+1)'),
    ('Sqrt(1+x^2)', '(x)/((2)root(1+(x)^(2))'));
const difHardFuncHard: array[0..7] of array[0..1] of string =(
('Root(4, (5*(x)^2-2)^3)', '(2*(x)^(2))/((3)root((x)^(3)+1)'),
('Root(4, (5*(x)^2-2)^3)', '(15*x)/(2*(4)root(5*(x)^(2)-2))'),
('ln((x)^(2)+1)-cos(x)', '(2*x)/((x)^(2)+1)+sin(x)'),
('Pow(e, 3*x)*sin(2*x)', '2*exp(3*x)*sin(2*x)+2*exp(3*x)*cos(2*x)'),
  ('ln(sin(5*x))', '5*ctg(5*x)'),
  ('sin(ln(5*x))', '(cos(ln(5)+ln(x)))/(x)'),
  ('cos(3*x)*sin(5*x)', '5*cos(3*x)*cos(5*x)-3*sin(3*x)*sin(5*x)'),
  ('-arctg(cos(ln(6*x)))', '(sin(ln(6*x)))/(x+x*(cos(ln(6*x)))^(2))'));

  const difSumSimp: array[0..35] of array[0..1] of string =(
  ('x-25+(2/7)*(x)^(14)', '1+4*(x)^(13)'),
  ('(3*x)/(10)-7*(x)^(6)-12','(3)/(10)-42*(x)^(5)'),
  ('3*(x)^(6)-14*(x)^(3)+34','18*(x)^(5)-42*(x)^(2)'),
  ('((x)^(3))/(3)-6*(x)^(2)','(x)^(2)-12*x'),
  ('2*(x)^(3)-6*Sqrt(x)', '6*(x)^(2)-(3)/((2)root(x))'),
  ('(8*(x)^(15))/(10)+12*Sqrt(x)','12*(x)^(14)-(6)/((2)root(x))'),
  ('1.2*(x)^(10)-3-2*Sqrt(x)', '12*(x)^(9)-(1)/((2)root(x))'),
  ('7*(x)^(5)+2*Sqrt(x)', '35*(x)^(4)+(1)/((2)root(x))'),
  ('5*(x)^(7)-4*Sqrt(x)', '35*(x)^(6)-(2)/((2)root(x))'),
  ('(3*(x)^(21))/(7)-2*Sqrt(x)+1.3', '9*(x)^(20)-(1)/((2)root(x))'),
  ('(x)/(3)-(7)/(2)*(x)^(2)+10', '(1)/(3)-7*x'),
  ('2*(x)^(6)+x*Sqrt(x)', '12*(x)^(5)+ (3*(2)root(x))/(2)'),
  ('15-8*(x)^(2)+(x)^(4)-Sqrt(x)','4*(x)^(3)-16*x-(1)/(2*(2)root(x))'),
  ('(1)/(7)+7*(x)^(4)', '28*(x)^(3)'),
  ('8*(x)^(5)+x-23+8*Sqrt(x)', '40*(x)^(4)+1+(4)/((2)root(x))'),
  ('Sqrt(x)+2*(x)^(5)+14-(x)^(7)', '(1)/(2*(2)root(x))+10*(x)^(4)-7*(x)^(6)'),
  ('18-Root(3,x)+10*x-36*x^2', '10-(1)/(3*(3)root((x)^(2)))-72*x'),
  ('x^7+x-5', '(x)^(6)+1'),
  ('(-1)/((x)^(2))+2*Sqrt(x)', '(2)/((x)^(3))+(1)/((2)root(x))'),//добавлен минус
  ('-4*x+x^4', '4*(x)^(3)-4'),
  ('x^9+1/x', '9*(x)^(8)-(1)/((x)^(2))'),
   ('-Pow(x,-1)-x^2+1', '(1)/((x)^(2))-2*x'),//добавлен минус
   ('6*x-3+x^5', '6+5*(x)^(4)'),
   ('4+pi+Sqrt(7)', '0'),
   ('x^10+x-3', '10*(x)^(9)+1'),
   ('x^7-3*x+2', '7*(x)^(6)-3'),
   ('x^8-3*x+2', '8*(x)^(7)-3'),
   ('-Pow(x,-5)+Sqrt(x)-pi', '(5)/((x)^(6))+(1)/((2)root(x))'),
   ('x^3-2*x', '3*(x)^(2)-2'),
   ('4*(x)^(2)-5/x', '8*x+(5)/((x)^(2))'),
   ('5*Pow(e,x)+25', '5*exp(x)'),
   ('4+2*Pow(e,x)', '2*exp(x)'),   //добавлен минус
   ('3*x^2-2*x', '6*x-2'),
   ('2*sin(x)+cos(x)', '2*cos(x)-sin(x)'),
   ('Pow(e,x)+ln(x)', 'exp(x)+(1)/(x)'),
   ('2*x^3-5*x^2+4*x-7', '6*(x)^(2)-5*x+4'));
  const difSumHard: array[0..7]of array[0..1] of string =(//17 и 18 функции повторялись
  ('4*x^2-(7)/(x^2)', '8*x+(14)/((x)^(3))'),
 ('x/3-(7)/(2*x^2)+10', '(1)/(3)+(7)/((x)^(3))'),
  ('(-13)/(x^4)-4*x^3','(56)/((x)^(5))-12*(x)^(2)'),
  ('(1)/(3*x^9)+6+4*Sqrt(x)','(3)/((x)^(10))+2/((2)root(x))'),//добавил минус
  ('(-3)/(x^7)+5*x^4', '(21)/((x)^(8))+20*(x)^(3)'),//добавил минус
  ('1/x^2+3*x^4', '12*(x)^(3)-(2)/((x)^(3))'),
  ('(Pow(x, 3/4))/2+2*(x)^(1/3)','(3)/(8*(4)root(x)+(2)/(3*(3)root((x)^(2)))'),
  ('4*Sqrt(x)-3/x', '(2)/((2)root(x))+(3)/((x)^(2))'));


 const difElemFuncSimp: array[0..17] of array[0..1] of string = (
 ('x^7','7*(x)^(6)'),
 ('x^(23/10)','(23*(x)^((13)/(10)))/(10)'),//перевел в обыкновенную дробь
 ('-x^(-5)','(5)/((x)^(6))'),
 ('3*(x)^(6)','18*(x)^(5)'),
 ('2*(x)^(3)', '6*(x)^(2)'),
 ('(x/5)^3','(3*(x)^(2))/(125)'),
 ('-x^(-4)','(4)/((x)^(5))'),
 ('5*Sqrt(x)','(5)/(2*(2)root(x))'),
 ('Sqrt(x)/3','(1)/(6*(2)root(x))'),
 ('Sqrt(x)/6','(1)/(12*(2)root(x))'),
 ('6*Sqrt(x)','(3)/((2)root(x))'),
 ('-1/x','(1)/((x)^(2))'),
 ('x^(71/10)','(71*(x)^((61)/(10)))/(10)'),
 ('-x^(-14)','(14)/((x)^(15))'),       //добавил минус
 ('x^(1/3)','(1)/((3)root((x)^(2)))'),
 ('Root(7,x^3)','(3)/(7*(7)root((x)^(4)))'),
 ('3*x^(6/13)','(18)/(13*(13)root((x)^(7)))'),
 ('2*Root(8,x^5)','(5)/(4*(8)root((x)^(3)))'));

 const difElemFuncHard: array[0..14] of array[0..1] of string =(
 ('Sqrt(x)/3','(1)/(6*(2)root(x))'),
 ('-x^(-7/4)', '(7*(x)^((3)/(4)))/(4)'),//добавил минус
 ('-1/(Sqrt(x))','1/(2*(2)root((x)^(3)))'),//добавил минус
 ('-1/(x^2)','(2)/((x)^(3))'),//добавил минус
 ('-1/Sqrt(x)','(1)/(2*(2)root(x))'),//добавил минус
 ('x*Sqrt(x)','(3*(2)root(x))/(2)'),
 ('x^(2)*Sqrt(x)','(5*(2)root((x)^(3)))/(2)'),
 ('-3/Root(8, x^3)','(9)/(8*(8)root((x)^(11)))'),//добавил минус
 ('-1/(x^6)','(6)/((x)^(7))'),//добавил минус
 ('-1/(x^(1/7))','(1)/(7*(x)^((8)/(7)))'),//добавил минус
 ('-1/(Root(9, x^2)','(2)/(9*(9)root((x)^(11)))'),//добавил минус
 ('Root(5, x^4)','(4)/(5*(5)root(x))'),
 ('-1/(Root(7, x^5)','(5)/(7*(7)root((x)^(12)))'),//добавил минус
 ('-7*(x)^(-4/7)','(4)/((x)^((3)/(7)))'),//добавил минус
 ('1/(x^(14))','(14)/((x)^(15))'));//добавил минус
 const secRuleSimp: array[0..15] of array[0..1] of string=
 (('3*(x)^(4)', '12*(x)^(2)'),
   ('2*(x)^(7)', '14*(x)^(6)'),  //убрал минус
   ('7*(x)^(3)', '21*(x)^(2)'),  //убрал минус
   ('1.5*(x)^(4)', '6*(x)^(3)'),
   ('-8*(x)^(-5)', '(40)/((x)^(6))'),
   ('6*Sqrt(x))', '(3)/((2)root(x))'),
   ('-3/x', '(3)/((x)^(2))'), //добавил минус
    ('2*Sqrt(x))', '(1)/((2)root(x))'),//убрал минус
    ('-3*(x)^(-5)', '(15)/((x)^(6))'), //добавил минус
    ('(x)/(2)', '(1)/(2)'),//убрал минус
    ('-8*(x)^(-2)', '(16)/((x)^(3))'),//добавил минус
    ('(3-x)*Pow(3,x)','ln(3)*(3)^(x+1)-(3)^(x)-ln(3)*x*(3)^(x)'),
    ('2*x*Pow(5,x)', '2*(5)^(x)+2*ln(5)*x*(5)^(x)'),
   ('(7^x)*Sqrt(x)', '((7)^(x)+2*ln(7)*x*(7)^(x))/(2*(2)root(x))'),
   ('(x^2+3)*(2*x^3-x+1)', '10*(x)^(4)+15*(x)^(2)+2*x-3'),
   ('(2*x^3+3*x^2-4*x+1)*(x-1)', '2*(x)^(3)+3*(x)^(2)-4*x+1'));
const secRuleHard: array[0..1] of array[0..1] of string =(
('Sqrt(2*x)','(1)/(2*(2)root(2*x))'),
('-4/(x^3)','(12)/((x)^(4))')); //добавил минус
implementation

{$R *.dfm}
{work with inputLine}

function retHardFunc(curEl: Element): TExprClass;forward;


function retClassicArray(inpArr: array of Element):TExprClass;
var a, b: TExprClass;
lenOfArr : integer;
begin
  lenOfArr := length(inpArr);
  if lenOfArr <>0 then
  begin
  if (inpArr[0].TypeOfFunc = 0) and (length(inpArr[0].data) > 0) then
    if inpArr[0].data ='x' then
    begin
        a:= TExprSimple.Create('x');
        User_answer:=User_Answer + 'x';
    end
    else
    begin
       a:= TExprNumber.Create(StrToInt(inpArr[0].data), False);
       User_answer:=User_Answer + inpArr[0].data;
    end

  else
  if (inpArr[0].TypeOfFunc = 0) and(length(inpArr[0].data) = 0) then
   begin
    lenOfArr:=-1;
    a:=  TExprSimple.Create('...')
  end
  else
  if (inpArr[0].TypeOfFunc >0 ) and (length(inpArr[0].data) = 0) then
    a:= retHardFunc(inpArr[0])
  else
  begin
    lenOfArr:=-1;
    a:=  TExprSimple.Create('...')
  end;
  end
  else
  begin
      lenOfArr:=-1;
    a:=  TExprSimple.Create('...')
  end;
  for var i :=1  to lenOfArr-1 do
    begin
      if inpArr[i].TypeOfFunc = 0 then
      begin
        if i mod 2 =0 then
        begin
             if inpArr[i].data ='x' then
              begin
                a.AddNext( TExprSimple.Create('x')) ;
                User_answer:=User_Answer +'x';
              end
              else
              begin
                a.AddNext( TExprNumber.Create(StrToInt(inpArr[i].data), False));
                User_answer:=User_Answer + inpArr[i].data;
              end



        end
        else
        begin
        var s: string;
        s := inpArr[i].data;
          if s ='+' then
            a.AddNext( TExprSign.Create(esPlus))
          else
          if s ='-' then
          a.AddNext(TExprSign.Create(esMinus))
          else
          if s ='*' then
          a.AddNext(TExprSign.Create(esMultiply));
         User_answer:=User_Answer +s;
        end;

      end
      else
      begin
        a.AddNext(retHardFunc(inpArr[i]));
      end;
    end;
    retClassicArray := a;
end;

function retHardFunc(curEl: Element): TExprClass;
var a, b, c: TExprClass;
begin
   //type TrigomonetricAndExp = (sin, cos, tg ,ctg, arcsin, arccos, arctg, arccctg, exp, ln);

  //a:= TExprSimple.Create('ln');
  if curEl.TypeOfFunc = 1 then
  begin
  b:=retClassicArray(curEl.UpLine);
  b:= TExprChain(b);
  case curEl.whichTrigFunc of
    sin:
    begin
    a:= TExprSimple.Create('sin');
    User_answer:=User_Answer +'sin';
    end;
    cos:begin
    a:= TExprSimple.Create('cos');
    User_answer:=User_Answer +'cos';
    end ;
    tg:begin
    a:= TExprSimple.Create('tg');
    User_answer:=User_Answer +'tg';
    end ;
    ctg:begin
     a:= TExprSimple.Create('ctg');
     User_answer:=User_Answer +'ctg';
     end;
    arcsin:begin
    a:= TExprSimple.Create('arcsin');
    User_answer:=User_Answer +'arcsin';
    end;
    arccos:begin
     a:= TExprSimple.Create('arccos');
     User_answer:=User_Answer +'arccos';
     end;
    arctg:begin
    a:= TExprSimple.Create('arctg');
     User_answer:=User_Answer +'arctg'
     end;
    arcctg:
    begin
    a:= TExprSimple.Create('arcctg');
    User_answer:=User_Answer +'arcctg';
    end ;
    exp:
    begin
    a:= TExprIndex.Create(TExprSimple.Create('e'),nil,TExprBracketed.Create(b,ebRound,ebRound));
    User_answer:=User_Answer +'exp';
    end;
    ln:begin
    a:= TExprSimple.Create('ln') ;
    User_answer:=User_Answer +'ln'
    end;
  end;
  User_answer:=User_Answer +'(';
  if curEl.whichTrigFunc <> exp then
  begin
    a.AddNext(TExprBracketed.Create(b,ebRound,ebRound));
  end;
  User_answer:=User_Answer +')';
  end
  else
  begin
     User_answer:=User_Answer +'(';
     b:=retClassicArray(curEl.UpLine);
     User_answer:=User_Answer +')';
     case curEl.whichTwoArgFunc of
       power:User_answer:=User_Answer +'^' ;
       log:User_answer:=User_Answer +'log' ;
       root:User_answer:=User_Answer +'root' ;
       del: User_answer:=User_Answer +'/';
     end;

     User_answer:=User_Answer +'(';
   c:=retClassicArray(curEl.DownLine);
   User_answer:=User_Answer +')';
   case CurEl.whichTwoArgFunc of
     power: a:= TExprIndex.Create(TExprBracketed.Create(b,ebRound,ebRound),nil,TExprBracketed.Create(c,ebRound,ebRound));
     log:begin
     a:= TExprIndex.Create(TExprSimple.Create('log'),TExprBracketed.Create(b,ebRound,ebRound), nil);
     a.AddNext(TExprBracketed.Create(c,ebRound,ebRound))
     end;
     root:
     a:= TExprRoot.Create(TExprBracketed.Create(c,ebRound,ebRound),TExprBracketed.Create(b,ebRound,ebRound));
     del: a:=TExprRatio.Create(TExprBracketed.Create(b,ebRound,ebRound),TExprBracketed.Create(c,ebRound,ebRound));
   end;
  end;
  retHardFunc := a;
end;

procedure ShowFormula();
var outStr: TExprClass;
begin
User_answer:='';
  Form1.Image3.Canvas.Brush.Color:=clWhite;
  Form1.Image3.Canvas.FillRect(Form1.Image1.ClientRect);

  OutStr := retClassicArray(inpLine);
  OutStr := TExprChain.Create(OutStr);
  OutStr.Font.Size:=12;
  OutStr.Canvas:=Form1.Image3.Canvas;
  OutStr.Draw(5,5,ehLeft, evTop);
  OutStr.Free;
end;

function initElement(typeOfFunc: integer): Element;
var
a: Element;
begin
  a.data:='';
  a.lenOfUpLine :=0;
  a.lenOfDownLine:=0;
  a.curElOfLine:=0;
  a.TypeOfFunc:=typeOfFunc;
  a.deep:=0;
  a.prevDeepLevel:=nil;
  initElement := a;
end;

procedure AddNum(a: string);
   var cuLen: integer;
begin
if curDeep = 0 then
begin
  if currentElement mod 2 = 0 then
  begin
  if a = 'x' then
    inpLine[currentElement].data:= '';
     inpLine[currentElement].data:= inpLine[currentElement].data+a;
  end
  else
  begin
    inc(currentElement);
    setlength(inpLine, currentElement+1);
    inpLine[currentElement] := initElement(0);
    if a = 'x' then
    inpLine[currentElement].data:= '';
    inpLine[currentElement].data:= inpLine[currentElement].data+a;
  end;
end
else
begin
   if (thisLev.curElOfLine+1 = thisLev.lenOfUpLine) or (thisLev.lenOfUpLine = 0 ) then
   begin

       cuLen := thisLev.curElOfLine;
       if cuLen mod 2 = 0 then
       begin
         if thisLev.lenOfUpLine = 0 then
         begin
         thisLev.lenOfUpLine := cuLen+1;
         thisLev.curElOfLine := cuLen;
         setlength(thisLev.UpLine, cuLen+1);
         thisLev.UpLine[cuLen] := initElement(0);
         end;
         if a = 'x' then
            thisLev.UpLine[cuLen].data:= '';
         thisLev.UpLine[cuLen].data := thisLev.UpLine[cuLen].data + a;
       end
       else
       begin
         inc(cuLen);
         thisLev.lenOfUpLine := cuLen+1;
         thisLev.curElOfLine := cuLen;
         setlength(thisLev.UpLine, cuLen+1);
         thisLev.UpLine[cuLen] := initElement(0);
         if a = 'x' then
            thisLev.UpLine[cuLen].data:= '';
         thisLev.UpLine[cuLen].data := thisLev.UpLine[cuLen].data + a;
       end;
   end
   else
   begin


       cuLen := thisLev.curElOfLine - thisLev.lenOfUpLine;

       if cuLen mod 2 = 0 then
       begin
       if thisLev.lenOfDownLine = 0 then
        begin
           thisLev.lenOfDownLine := cuLen+1;
         thisLev.curElOfLine :=thisLev.curElOfLine+ cuLen;
         setlength(thisLev.DownLine, cuLen+1);

         thisLev.DownLine[cuLen]:= initElement(0);
        end;
        if a = 'x' then
            thisLev.DownLine[cuLen].data:= '';
         thisLev.DownLine[cuLen].data := thisLev.DownLine[cuLen].data + a;
       end
       else
       begin
         inc(cuLen);
         thisLev.lenOfDownLine := cuLen+1;
         thisLev.curElOfLine := thisLev.curElOfLine+ cuLen;
         setlength(thisLev.DownLine, cuLen+1);
         thisLev.DownLine[cuLen]:= initElement(0);
         if a = 'x' then
            thisLev.DownLine[cuLen].data:= '';
         thisLev.DownLine[cuLen].data := thisLev.DownLine[cuLen].data + a;
       end;


   end;

end;
  ShowFormula;
end;

procedure AddPlusMinusMult(a:string);
var cuLen:integer;
begin
if curDeep = 0 then
begin

  if currentElement mod 2 = 1 then
    begin
      inpLine[currentElement].data:= a;
    end
    else
    begin
      inc(currentElement);
      setlength(inpLine, currentElement+1);
      inpLine[currentElement].data:='';
      inpLine[currentElement].TypeOfFunc:=0;
      inpLine[currentElement].data:= a;
    end;
  end
else
begin

  if thisLev.curElOfLine+1 = thisLev.lenOfUpLine then
   begin
       cuLen := thisLev.curElOfLine;
       if cuLen mod 2 = 1 then
       begin
         thisLev.UpLine[cuLen].data := a;
       end
       else
       begin
         inc(cuLen);
         thisLev.lenOfUpLine := cuLen+1;
         thisLev.curElOfLine := cuLen;
         setlength(thisLev.UpLine, cuLen+1);
         thisLev.UpLine[cuLen]:= initElement(0);
         thisLev.UpLine[cuLen].deep := curDeep;
         thisLev.UpLine[cuLen].data := a;
       end;
   end
   else
   begin

       cuLen := thisLev.curElOfLine - thisLev.lenOfUpLine;

       if cuLen mod 2 = 1 then
       begin
         thisLev.DownLine[cuLen].data := a;
       end
       else
       begin
         inc(cuLen);
         thisLev.lenOfDownLine := cuLen+1;
         thisLev.curElOfLine := thisLev.curElOfLine+ cuLen;
         setlength(thisLev.DownLine, cuLen+1);
         thisLev.DownLine[cuLen]:= initElement(0);
         thisLev.DownLine[cuLen].deep := curDeep;
         thisLev.DownLine[cuLen].data := a;
       end;


   end;

end;
  ShowFormula
end;

procedure addSimpFunc(a: TrigomonetricAndExp);
 var cuLen: integer;
begin
   if curDeep = 0 then
begin
  if currentElement mod 2 = 0 then
  begin
     inpLine[currentElement]:=initElement(1);
     inpLine[currentElement].whichTrigFunc := a;
     inpLine[currentElement].deep:= curDeep + 1;
     thisLev:= @inpLine[currentElement];
  end
  else
  begin
      inc(currentElement);
    setlength(inpLine, currentElement+1);
     inpLine[currentElement]:= initElement(1);
     inpLine[currentElement].whichTrigFunc := a;
     inpLine[currentElement].deep:= curDeep + 1;
     thisLev:= @inpLine[currentElement];
  end;
end
else
begin
   if (thisLev.curElOfLine+1 = thisLev.lenOfUpLine) or (thisLev.lenOfUpLine = 0 )then
   begin

       cuLen := thisLev.curElOfLine;
       if cuLen mod 2 = 0 then
       begin
       if thisLev.lenOfUpLine = 0 then
         begin
         thisLev.lenOfUpLine := cuLen+1;
         thisLev.curElOfLine := cuLen;
         setlength(thisLev.UpLine, cuLen+1);
         end;
           thisLev.UpLine[cuLen]:=initElement(1);
     thisLev.UpLine[cuLen].whichTrigFunc := a;
     thisLev.UpLine[cuLen].deep:= curDeep + 1;
     thisLev.UpLine[cuLen].prevDeepLevel:=@thisLev^;
     thisLev:= @thisLev.UpLine[cuLen];
       end
       else
       begin

          inc(cuLen);
         thisLev.lenOfUpLine := cuLen+1;
         thisLev.curElOfLine := cuLen;
         setlength(thisLev.UpLine, cuLen+1);
         thisLev.UpLine[cuLen]:= initElement(1);
     thisLev.UpLine[cuLen].whichTrigFunc := a;
     thisLev.UpLine[cuLen].deep:= curDeep + 1;
     thisLev.UpLine[cuLen].prevDeepLevel:=@thisLev^;
     thisLev:= @thisLev.UpLine[cuLen];
       end;
   end
   else
   begin

       cuLen := thisLev.curElOfLine - thisLev.lenOfUpLine;

       if cuLen mod 2 = 0 then
       begin
       if thisLev.lenOfDownLine = 0 then
         begin
         thisLev.lenOfDownLine := cuLen+1;
         thisLev.curElOfLine := thisLev.curElOfLine+ cuLen;
         setlength(thisLev.DownLine, cuLen+1);
         thisLev.DownLine[cuLen] := initElement(1);
         end;
          thisLev.DownLine[cuLen]:=initElement(1);
     thisLev.DownLine[cuLen].whichTrigFunc := a;
     thisLev.DownLine[cuLen].deep:= curDeep + 1;
     thisLev.DownLine[cuLen].prevDeepLevel:=@thisLev^;
     thisLev:= @thisLev.DownLine[cuLen];
       end
       else
       begin
          inc(cuLen);
         thisLev.lenOfDownLine := cuLen+1;
         thisLev.curElOfLine := thisLev.curElOfLine+ cuLen;
         setlength(thisLev.DownLine, cuLen+1);
         thisLev.DownLine[cuLen]:=initElement(1);
     thisLev.DownLine[cuLen].whichTrigFunc := a;
     thisLev.DownLine[cuLen].deep:= curDeep + 1;
     thisLev.DownLine[cuLen].prevDeepLevel:=@thisLev^;
     thisLev:= @thisLev.DownLine[cuLen];
       end;


   end;

end;
curDeep := curDeep + 1;
ShowFormula();
end;


procedure HardFunct(a: PowOrLogrRoot);
 var cuLen: integer;
begin
   if curDeep = 0 then
begin
  if currentElement mod 2 = 0 then
  begin
     inpLine[currentElement]:=initElement(2);
     inpLine[currentElement].whichTwoArgFunc := a;
     inpLine[currentElement].deep:= curDeep + 1;
     thisLev:= @inpLine[currentElement];
  end
  else
  begin
      inc(currentElement);
    setlength(inpLine, currentElement+1);
     inpLine[currentElement]:= initElement(2);
     inpLine[currentElement].whichTwoArgFunc := a;
     inpLine[currentElement].deep:= curDeep + 1;
     thisLev:= @inpLine[currentElement];
  end;
end
else
begin
   if (thisLev.curElOfLine+1 = thisLev.lenOfUpLine)or (thisLev.lenOfUpLine = 0 ) then
   begin
       cuLen := thisLev.curElOfLine;
       if cuLen mod 2 = 0 then
       begin
       if thisLev.lenOfUpLine = 0 then
         begin
         thisLev.lenOfUpLine := cuLen+1;
         thisLev.curElOfLine := cuLen;
         setlength(thisLev.UpLine, cuLen+1);
         thisLev.UpLine[cuLen] := initElement(2);
         end;
           thisLev.UpLine[cuLen]:=initElement(2);
     thisLev.UpLine[cuLen].whichTwoArgFunc := a;
     thisLev.UpLine[cuLen].deep:= curDeep + 1;
     thisLev.UpLine[cuLen].prevDeepLevel:=@thisLev^;
     thisLev:= @thisLev.UpLine[cuLen];
       end
       else
       begin

          inc(cuLen);
         thisLev.lenOfUpLine := cuLen+1;
         thisLev.curElOfLine := cuLen;
         setlength(thisLev.UpLine, cuLen+1);
         thisLev.UpLine[cuLen]:= initElement(2);
     thisLev.UpLine[cuLen].whichTwoArgFunc := a;
     thisLev.UpLine[cuLen].deep:= curDeep + 1;
     thisLev.UpLine[cuLen].prevDeepLevel:=@thisLev^;
     thisLev:= @thisLev.UpLine[cuLen];
       end;
   end
   else
   begin
       cuLen := thisLev.curElOfLine - thisLev.lenOfUpLine;

       if cuLen mod 2 = 0 then
       begin
       if thisLev.lenOfDownLine = 0 then
         begin
         thisLev.lenOfDownLine := cuLen+1;
         thisLev.curElOfLine := cuLen;
         setlength(thisLev.DownLine, cuLen+1);
         thisLev.DownLine[cuLen] := initElement(2);
         end;
          thisLev.DownLine[cuLen]:=initElement(2);
     thisLev.DownLine[cuLen].whichTwoArgFunc := a;
     thisLev.DownLine[cuLen].deep:= curDeep + 1;
     thisLev.DownLine[cuLen].prevDeepLevel:=@thisLev^;
     thisLev:= @thisLev.DownLine[cuLen];
       end
       else
       begin
          inc(cuLen);
         thisLev.lenOfDownLine := cuLen+1;
         thisLev.curElOfLine := thisLev.curElOfLine+ cuLen;
         setlength(thisLev.DownLine, cuLen+1);
         thisLev.DownLine[cuLen]:=initElement(2);
     thisLev.DownLine[cuLen].whichTwoArgFunc := a;
     thisLev.DownLine[cuLen].deep:= curDeep + 1;
     thisLev.DownLine[cuLen].prevDeepLevel:=@thisLev^;
     thisLev:= @thisLev.DownLine[cuLen];
       end;


   end;

end;
curDeep := curDeep + 1;
ShowFormula();
end;


 {end of work with inputLine}
procedure TForm1.EnterPlusClick(Sender: TObject);
begin
  AddPlusMinusMult('+');
end;

procedure TForm1.Enter6Click(Sender: TObject);
begin
  addNum('6');
end;

procedure TForm1.Enter7Click(Sender: TObject);
begin
  addNum('7');
end;

procedure TForm1.Enter8Click(Sender: TObject);
begin
  addNum('8');
end;

procedure TForm1.Enter9Click(Sender: TObject);
begin
  addNum('9');
end;

procedure TForm1.EnterMinusClick(Sender: TObject);
begin
AddPlusMinusMult('-');
end;

procedure TForm1.EnterMultClick(Sender: TObject);
begin
AddPlusMinusMult('*');
end;

procedure TForm1.EntBackspaceClick(Sender: TObject);
begin
inpLine[currentElement] := initElement(0);
curDeep:=0;
thisLev := nil;
if currentElement > 0 then
begin
setlength(inpLine, currentElement);
currentElement:=currentElement -1;
end;
ShowFormula();
end;

procedure TForm1.Enter0Click(Sender: TObject);
begin
 addNum('0');
end;

procedure TForm1.EnterRootClick(Sender: TObject);
begin
HardFunct(Root);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Panel2.Visible:= True;
  Panel1.Visible:= False;
end;

procedure TForm1.EnterLnClick(Sender: TObject);
begin
  addSimpFunc(ln);
end;

procedure TForm1.EnterlogClick(Sender: TObject);
begin
HardFunct(Log);
end;

procedure TForm1.EnterexpClick(Sender: TObject);
begin
addSimpFunc(exp);
end;

procedure TForm1.EntersinClick(Sender: TObject);
begin
addSimpFunc(sin);
end;

procedure TForm1.EnterStepClick(Sender: TObject);
begin
HardFunct(Power);
end;

procedure TForm1.EntercosClick(Sender: TObject);
begin
  addSimpFunc(cos);
end;

procedure TForm1.EntertgClick(Sender: TObject);
begin
  addSimpFunc(tg);
end;

procedure TForm1.EnterCtgClick(Sender: TObject);
begin
addSimpFunc(ctg);
end;

procedure TForm1.EnterDelClick(Sender: TObject);
begin
HardFunct(del);
end;

procedure TForm1.EnterArcsinClick(Sender: TObject);
begin
      addSimpFunc(arcsin);
end;

procedure TForm1.EnterArccosClick(Sender: TObject);
begin
AddSimpFunc(arccos);
end;

procedure TForm1.EnterarctgClick(Sender: TObject);
begin
addSimpFunc(arctg);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Panel1.Visible:= True;
  Panel2.Visible:= False;
end;

procedure TForm1.EnterArcctgClick(Sender: TObject);
begin
 addSimpFunc(arcctg);
end;

procedure TForm1.NextElClick(Sender: TObject);
begin
if curDeep <> 0 then
   if thisLev.TypeOfFunc = 1 then
   begin
   thisLev := @(thisLev.prevDeepLevel^);
   curDeep := curDeep-1;
   end
   else
   begin
      if thisLev.lenOfDownLine = 0 then
      inc(thisLev.curElOfLine)
      else
      begin
        curDeep := curDeep-1;
        thisLev:=@(thisLev.prevDeepLevel^);
      end;

   end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var ExprMk: TExprBuilder;
OutF: TExprClass;
a, b:integer;
begin
  Form1.Image3.Canvas.Brush.Color:=clWhite;
  Form1.Image3.Canvas.FillRect(Form1.Image1.ClientRect);
  randomize;
if (ComboBox2.ItemIndex<0) or (combobox3.ItemIndex < 0) or(Edit1.Text = '') or(Edit1.Text = '0') then

  MessageDlg('Выберите блок задач, уровень сложности и количество заданий', mtWarning, [mbOk], 0)
else
begin
numOfTask :=StrToInt(Edit1.Text);
case combobox2.ItemIndex of
0:
begin
 if combobox3.ItemIndex=0 then
 begin
    b:= numOfTask - 30;
 end
 else
 begin
    b:= numOfTask - 3;
 end;
end;
1:
begin
  if combobox3.ItemIndex=0 then
 begin
   b:= numOfTask - 21;
 end
 else
 begin
    b:= numOfTask - 8;
 end;
end;
2:begin
  if combobox3.ItemIndex=0 then
 begin
    b:= numOfTask - 36;
 end
 else
 begin
    b:= numOfTask - 8;
 end;
end;
3:
begin
  if combobox3.ItemIndex=0 then
 begin
    b:= numOfTask - 18;
 end
 else
 begin
    b:= numOfTask - 15;
 end;
end;
4: begin
  if combobox3.ItemIndex=0 then
 begin
    b:= numOfTask - 16;
 end
 else
 begin
    b:= numOfTask - 2;
 end;
end;
end;

if b <=0 then

begin
  numOfAnswers:=0;
  case combobox2.ItemIndex of
  0:
  begin
  if combobox3.ItemIndex=0 then
  begin
  a:=random(30);
    taskString:=thirdRuleSimp[a][0];
    correctAnswer:= thirdRuleSimp[a][1]
    end
    else
    begin
     a:=random(3);
    taskString:=thirdRuleHard[a][0];
    correctAnswer:= thirdRuleHard[a][1]
  end;
  end;
  1:
  begin
    if combobox3.ItemIndex=0 then
  begin
  a:=random(21);
    taskString:=difHardFuncSimp[a][0];
    correctAnswer:= difHardFuncSimp[a][1]
    end
    else
    begin
     a:=random(8);
    taskString:=difHardFuncHard[a][0];
    correctAnswer:= difHardFuncHard[a][1]
  end;
  end;
  2:
  begin
    if combobox3.ItemIndex=0 then
  begin
  a:=random(36);
    taskString:=difSumSimp[a][0];
    correctAnswer:= difSumSimp[a][1]
    end
    else
    begin
     a:=random(8);
    taskString:=difSumHard[a][0];
    correctAnswer:= difSumHard[a][1]
  end;
  end;
  3:
  begin
    if combobox3.ItemIndex=0 then
  begin
  a:=random(18);
    taskString:=difElemFuncSimp[a][0];
    correctAnswer:= difElemFuncSimp[a][1]
    end
    else
    begin
     a:=random(15);
    taskString:=difElemFuncHard[a][0];
    correctAnswer:= difElemFuncHard[a][1]
  end;
  end;
  4:
  begin
     if combobox3.ItemIndex=0 then
  begin
  a:=random(16);
    taskString:=secRuleSimp[a][0];
    correctAnswer:= secRuleSimp[a][1]
    end
    else
    begin
     a:=random(2);
    taskString:=secRuleHard[a][0];
    correctAnswer:= secRuleHard[a][1]
  end;
  end;
  end;
  Label8.Caption:='0 задач из ' + intToStr(numOfTask) +' выполнено.';
  if numOfTask = 1 then
  begin
    button5.Caption:='Сдать задание'
  end
  else
  begin
      button5.Caption:='Следующее задание'
  end;
  setlength(wasThisTask, 2);
     wasthisTask[0] :=2;
        wasthisTask[1] :=a;
  Label7.Visible:=False;
  Edit1.Visible:=False;
  Edit1.Text:='';
  combobox2.Visible:= False;
  combobox3.Visible:=False;
  label2.Visible:=False;
  Label3.Visible:=False;
  Panel3.Visible:=True;
  Button3.Visible:=False;
   numOfCorrectAnswers :=0;
  ExprMk := TExprBuilder.Create;
  Form1.Image2.Canvas.Brush.Color:=clWhite;
  Form1.Image2.Canvas.FillRect(Form1.Image1.ClientRect);

  OutF := ExprMk.BuildExpr(taskString);
  OutF.Font.Size:=12;
  OutF.Canvas:=Form1.Image2.Canvas;
  OutF.Draw(5,5,ehLeft, evTop);
  OutF.Free;
  lenOfArr:=1;
  setLength(inpLine, lenOfArr);
  currentElement:=0;
  inpLine[currentElement]:=initElement(0);
  thisLev := @inpLine;
  curDeep := 0;
end
else
begin
  MessageDlg('Уменьшите количество задач для данного блока', mtWarning, [mbOk], 0);
end;
end;
end;



procedure TForm1.Button4Click(Sender: TObject);
begin
Panel4.Visible:=False;
Panel1.Visible:=True;
ComboBox2.Items.Clear;
ComboBox2.Items.Add('3 правило дифференцирования');
ComboBox2.Items.Add('Производная сложной функции');
ComboBox2.Items.Add('Производная суммы, разности');
ComboBox2.Items.Add('Производная элементарной функции');
ComboBox2.Items.Add('2 правило дифференцирования');
end;

procedure TForm1.EnterXClick(Sender: TObject);
begin
  addNum('x');
end;

procedure TForm1.Enter1Click(Sender: TObject);
begin
  AddNum('1');
end;



procedure TForm1.Button5Click(Sender: TObject);
var answer : string;
a, i:integer;
ExprMk: TExprBuilder;
OutF: TExprClass;
flag: boolean;
begin
   answer:= User_Answer;
   User_Answer := '';
   if numOfAnswers + 1 < numOfTask then
    begin
    if answer = correctAnswer then
    begin
       numOfCorrectAnswers := numOfCorrectAnswers+1;
       MessageDlg('Ответ верный' , mtWarning, [mbOk], 0)
    end
    else
    begin
      MessageDlg('Ответ неверный, правильный ответ: '+#10#13+correctAnswer , mtWarning, [mbOk], 0)
    end;
    numOfAnswers := numOfAnswers+1;
    if numOfAnswers +1 = numOfTask then
    Button5.Caption:='Сдать задание';
    label8.Caption:= INtToStr(numOfAnswers)+' сделано из '+IntToStr(numOfTask);
   flag:=True;
     case combobox2.ItemIndex of
    0:
    begin
   if combobox3.ItemIndex=0 then
   begin
   while flag do
     begin
    flag:= False;
        a:=random(30);
       for i := 1 to wasThisTask[0]-1 do
       begin
         if a = wasThisTask[i] then
          begin
            flag:= True;
            break;
           end;
        end;
      end;
     wasThisTask[0]:= wasThisTask[0]+1;
     setlength(wasThisTask, wasThisTask[0]);
     wasThisTask[wasThisTask[0]-1] := a;
    taskString:=thirdRuleSimp[a][0];
    correctAnswer:= thirdRuleSimp[a][1]
    end
    else
    begin
     while flag do
     begin
    flag:= False;
        a:=random(3);
       for i := 1 to wasThisTask[0]-1 do
       begin
         if a = wasThisTask[i] then
          begin
            flag:= True;
            break;
           end;
        end;
      end;
      wasThisTask[0]:= wasThisTask[0]+1;
     setlength(wasThisTask, wasThisTask[0]);
     wasThisTask[wasThisTask[0]-1] := a;
    taskString:=thirdRuleHard[a][0];
    correctAnswer:= thirdRuleHard[a][1]
  end;
  end;
  1:
  begin
    if combobox3.ItemIndex=1 then
  begin
  while flag do
     begin
    flag:= False;
        a:=random(21);
       for i := 1 to wasThisTask[0]-1 do
       begin
         if a = wasThisTask[i] then
          begin
            flag:= True;
            break;
           end;
        end;
      end;
      wasThisTask[0]:= wasThisTask[0]+1;
     setlength(wasThisTask, wasThisTask[0]);
     wasThisTask[wasThisTask[0]-1] := a;
    taskString:=difHardFuncSimp[a][0];
    correctAnswer:= difHardFuncSimp[a][1]
    end
    else
    begin
     while flag do
     begin
    flag:= False;
        a:=random(8);
       for i := 1 to wasThisTask[0]-1 do
       begin
         if a = wasThisTask[i] then
          begin
            flag:= True;
            break;
           end;
        end;
      end;
      wasThisTask[0]:= wasThisTask[0]+1;
     setlength(wasThisTask, wasThisTask[0]);
     wasThisTask[wasThisTask[0]-1] := a;
    taskString:=difHardFuncHard[a][0];
    correctAnswer:= difHardFuncHard[a][1]
  end;
  end;
  2:
  begin
     if combobox3.ItemIndex=0 then
   begin
   while flag do
     begin
    flag:= False;
        a:=random(36);
       for i := 1 to wasThisTask[0]-1 do
       begin
         if a = wasThisTask[i] then
          begin
            flag:= True;
            break;
           end;
        end;
      end;
     wasThisTask[0]:= wasThisTask[0]+1;
     setlength(wasThisTask, wasThisTask[0]);
     wasThisTask[wasThisTask[0]-1] := a;
    taskString:=thirdRuleSimp[a][0];
    correctAnswer:= thirdRuleSimp[a][1]
    end
    else
    begin
     while flag do
     begin
    flag:= False;
        a:=random(8);
       for i := 1 to wasThisTask[0]-1 do
       begin
         if a = wasThisTask[i] then
          begin
            flag:= True;
            break;
           end;
        end;
      end;
      wasThisTask[0]:= wasThisTask[0]+1;
     setlength(wasThisTask, wasThisTask[0]);
     wasThisTask[wasThisTask[0]-1] := a;
    taskString:=thirdRuleHard[a][0];
    correctAnswer:= thirdRuleHard[a][1]
  end;
  end;
  3:
  begin
         if combobox3.ItemIndex=0 then
   begin
   while flag do
     begin
    flag:= False;
        a:=random(18);
       for i := 1 to wasThisTask[0]-1 do
       begin
         if a = wasThisTask[i] then
          begin
            flag:= True;
            break;
           end;
        end;
      end;
     wasThisTask[0]:= wasThisTask[0]+1;
     setlength(wasThisTask, wasThisTask[0]);
     wasThisTask[wasThisTask[0]-1] := a;
    taskString:=difElemFuncSimp[a][0];
    correctAnswer:= difElemFuncSimp[a][1]
    end
    else
    begin
     while flag do
     begin
    flag:= False;
        a:=random(15);
       for i := 1 to wasThisTask[0]-1 do
       begin
         if a = wasThisTask[i] then
          begin
            flag:= True;
            break;
           end;
        end;
      end;
      wasThisTask[0]:= wasThisTask[0]+1;
     setlength(wasThisTask, wasThisTask[0]);
     wasThisTask[wasThisTask[0]-1] := a;
    taskString:=difElemFuncHard[a][0];
    correctAnswer:= difElemFuncHard[a][1]
  end;
  end;
  4:
  begin
         if combobox3.ItemIndex=0 then
   begin
   while flag do
     begin
    flag:= False;
        a:=random(16);
       for i := 1 to wasThisTask[0]-1 do
       begin
         if a = wasThisTask[i] then
          begin
            flag:= True;
            break;
           end;
        end;
      end;
     wasThisTask[0]:= wasThisTask[0]+1;
     setlength(wasThisTask, wasThisTask[0]);
     wasThisTask[wasThisTask[0]-1] := a;
    taskString:=secRuleSimp[a][0];
    correctAnswer:= secRuleSimp[a][1]
    end
    else
    begin
     while flag do
     begin
    flag:= False;
        a:=random(2);
       for i := 1 to wasThisTask[0]-1 do
       begin
         if a = wasThisTask[i] then
          begin
            flag:= True;
            break;
           end;
        end;
      end;
      wasThisTask[0]:= wasThisTask[0]+1;
     setlength(wasThisTask, wasThisTask[0]);
     wasThisTask[wasThisTask[0]-1] := a;
    taskString:=secRuleHard[a][0];
    correctAnswer:= secRuleHard[a][1]
  end;
  end;
     end;

     ExprMk := TExprBuilder.Create;
  Form1.Image3.Canvas.Brush.Color:=clWhite;
  Form1.Image3.Canvas.FillRect(Form1.Image1.ClientRect);
  Form1.Image2.Canvas.Brush.Color:=clWhite;
  Form1.Image2.Canvas.FillRect(Form1.Image1.ClientRect);

  OutF := ExprMk.BuildExpr(taskString);
  OutF.Font.Size:=12;
  OutF.Canvas:=Form1.Image2.Canvas;
  OutF.Draw(5,5,ehLeft, evTop);
  OutF.Free;
  lenOfArr:=1;
  setLength(inpLine, lenOfArr);
  currentElement:=0;
  inpLine[currentElement]:=initElement(0);
  thisLev := @inpLine;
  curDeep := 0;

    end
    else
    begin
    if answer = correctAnswer then
       numOfCorrectAnswers := numOfCorrectAnswers+1;
   if numOfCorrectAnswers = numOfTask then
      MessageDlg('Все ответы верные' , mtWarning, [mbOk], 0)
   else
   MessageDlg('Верно '+INtToStr(numOfCorrectAnswers)+' из '+ IntToStr(numOfTask)+#10#13+'Правильно выполнено '+FloatToStr((numOfCorrectAnswers/numOfTask)*100)+' % теста', mtWarning, [mbOk], 0);
   Label7.Visible:=True;
  Edit1.Visible:=True;
  Edit1.Text:='';
   ComboBox2.Visible:= True;
  combobox3.Visible:=True;
  label2.Visible:=True;
  Label3.Visible:=True;
  Panel3.Visible:=False;
  Button2.Visible:=True;
  Button3.Visible:=True;
    end;
end;


procedure TForm1.Button6Click(Sender: TObject);
begin
Memo1.Visible:=True;
Memo1.Text:='Для перехода к теоретическому модулю нажмите "Приступить к практике". Для выбора теоретического блока нажмите';
Memo1.Text:=Memo1.Text+ 'на выпадающее меню и выберите соответствующий блок. Для перехода к практическим заданиям нажмите соответствующую';
Memo1.Text:=Memo1.Text+' кнопку. Выберите нужный практический блок, уровень сложности и количество задач, которое необхожимо решить, после чего запустите тест.';
Memo1.Text:=Memo1.Text+'Правила ввода производных:'+#13#10+'1)При вводе производной многочлена вводить нужно в том порядке, в котором берутся производные его слагаемых';
Memo1.Text:=Memo1.Text+#13#10 +'2)При вводе производной произведения и отношения вводить ее нужно в согласии с правилом дифференциирования производных';
Memo1.Text:=Memo1.Text+#13#10 +'3)При записывании производной сложной функции сначала вводится константа, затем по очереди производные функций в порядке возрастания их вложенности';
Memo1.Text:=Memo1.Text+#13#10 +'4)При вводе производных абсолютно все арифметические знаки нужно вводить';
button4.Visible:=False;
Button6.Visible:=False;
Button7.Visible:=False;
Button8.Visible:=True;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
Memo1.Visible:=True;
Memo1.Text:='Разработчик: Юмаев Александр';
Memo1.Text:=Memo1.Text+#13#10+#13#10+'Для отображения математических формул используются модули ExprDraw и ExprMake, разработанные Григорьевым Антоном, e-mail: grigorievab@mail.ru';
button4.Visible:=False;
Button6.Visible:=False;
Button7.Visible:=False;
Button8.Visible:=True;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
Memo1.Visible:=False;
Memo1.Text:='';
button4.Visible:=True;
Button6.Visible:=True;
Button7.Visible:=True;
Button8.Visible:=False;
end;

procedure TForm1.Enter2Click(Sender: TObject);
begin
  addNum('2');
end;

procedure TForm1.Enter3Click(Sender: TObject);
begin
  addNum('3');
end;

procedure TForm1.Enter4Click(Sender: TObject);
begin
  addNum('4');
end;

procedure TForm1.Enter5Click(Sender: TObject);
begin
  addNum('5');
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var a, myleft, mytop: integer;
TableOfDif, TableOfRules: array of string;
ExprMk: TExprBuilder;
OutF: TExprClass;
begin
    a := ComboBox1.ItemIndex;
    ExprMk := TExprBuilder.Create;
    Form1.Image1.Canvas.Brush.Color:=clWhite;
    Form1.Image1.Canvas.FillRect(Form1.Image1.ClientRect);
    TableOfDif := ['String("1) ") & !(C)`=0,C=const&space(20)&String("6) ") & !(e^x)`=e^x&space(90)&String("11) ")&!(arcsin(x))`=1/(sqrt(1-x^2))',
    'String("2) ") & !(sqrt(x))`=1/(2*sqrt(x))&space(60)&String("7) ") & !(sin(x))`=cos(x)&space(50)&String("12) ")&!(arccos(x))`=-1/(sqrt(1-x^2))',
     'String("3) ") & !(x^n)`=n*x^(n-1)&space(43)&String("8) ") & !(cos(x))`=-sin(x)&space(40)&String("13) ")&!(arctg(x))`=1/(sqrt(1+x^2))',
     'String("4) ") & !(ln(x))`=(1/x)&space(70)&String("9) ")&!(tg(x))`=1/(cos(x)^2)&space(50)&String("14) ")&!(arcctg(x))`=-1/(sqrt(1+x^2))',
      'String("5) ") & !(a^x)`=(a^x)*ln(a)&space(60)&String("10) ")&!(ctg(x))`=-1/(sin(x)^2)&space(40)&String("15) ")&!(x)`=1'];
    TableOfRules:=['(C*f(x))`=C*f(x)`&String(", где C-константа")',
    '(f(x)+g(x))`=f(x)`+g(x)`&String(", Производная суммы функций")',
    '(f(x)*g(x))`=f(x)`*g(x)+f(x)*g(x)`&String(", Производная произведения функций")',
    '(f(x)/g(x))`=(f(x)`*g(x)-f(x)*g(x)`)/(g(x)^2)&String(", Производная частного")'];
    if a = 0 then
    begin
      Label1.Caption:= 'Производной функции ƒ''(x) называется предел отношения приращения'#10#13+' функции к приращению аргумента при ∆x→0';
      OutF := ExprMk.BuildExpr('f(x0)`=lim(Delta&x->0, (f-f0)/(x-x0))');
      OutF.Font.Size:=12;
      OutF.Canvas:=Form1.Image1.Canvas;
      OutF.Draw(5,5,ehLeft, evTop);
      OutF.Free;
    end
    else
    if a = 1 then
    begin
      Label1.Caption:='ТАБЛИЦА ПРОИЗВОДНЫХ ОСНОВНЫХ ФУНКЦИЙ';
      mytop:=5;
      for var l :=0 to 4 do
      begin
        OutF := ExprMk.BuildExpr(TableOfDif[l]);
        OutF.Font.Size:=12;
        OutF.Canvas:=Form1.Image1.Canvas;
        OutF.Draw(5,mytop,ehLeft, evTop);
        mytop:= mytop + 50;
        OutF.Free;
      end
    end
    else
    begin
       Label1.Caption:='Правила дифференцирования';
       for var l :=0 to 3 do
      begin
        OutF := ExprMk.BuildExpr(TableOfRules[l]);
        OutF.Font.Size:=12;
        OutF.Canvas:=Form1.Image1.Canvas;
        OutF.Draw(5,mytop,ehLeft, evTop);
        mytop:= mytop + 50;
        OutF.Free;
      end
    end;

end;

end.
