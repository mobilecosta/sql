If OBJECT_ID('strzero') > 0
   DROP FUNCTION strzero
GO
CREATE FUNCTION strzero(@in_num integer, @in_zeros integer)
Returns VarChar(510)
As
Begin
   Declare @xText VarChar(510)

   If @in_num Is Null
      Set @in_num = 0
   Set @xText = ''
   While Len(@xText) < @in_zeros
   Begin
      Set @xText= @xText + '0000000000'
   End
   Set @xText = @xText + Convert(VarChar, @in_num)
   Return Right( @xText, @in_zeros )
End
GO

If OBJECT_ID('MSSTRZERO') > 0
   DROP PROCEDURE MSSTRZERO
GO
------------------------------------------------------------------------------
--    Procedure   -  Converte valor num‚rico Inteiro para String
--            		   com zeros … esquerda ( Como a StrZero )
--    Entrada     -  IN_VALOR   : Valor a ser Convertido
--                -  IN_INTEGER : Numero de Casas Inteiras
--    Saida       -  OUT_VALOR  : Valor de Retorno Tipo Char
--    Responsavel :  Emerson Tobar
--    Data        :  20/04/98
----------------------------------------------------------------------------
-- Criacao de procedure
create procedure MSSTRZERO (
    @IN_VALOR Integer ,
    @IN_INTEGER Integer ,
    @OUT_VALOR VarChar( 100 )  output ) with encryption as  
 
-- Declaracoes de variaveis
begin
   Set @OUT_VALOR  =  (Right ( Replicate ( '0' , @IN_INTEGER ) + Convert( VarChar( 255 ) ,@IN_VALOR ), @IN_INTEGER )) 
end

If OBJECT_ID('MSSOMA1') > 0
   DROP PROCEDURE MSSOMA1
GO
CREATE PROCEDURE MSSOMA1
(
  @IN_SOMAR      VarChar(100),
  @IN_SOMALOW    Char(01),
  @OUT_RESULTADO VarChar(100) OutPut
)
as
/* ------------------------------------------------------------------------------------
    Procedure       -     Soma1
    Descricao       - <d> Soma 1 numa string qualquer </d>
    Entrada         - <ri> @IN_SOMAR      - String a qual será somado 1
                           @IN_SOMALOW    - Considera letras minúsculas </ri>
    Saida           - <ro> @OUT_RESULTADO - String somada de 1 </ro>
    Responsavel :     <r> Alice Yamamoto	</r>
    Data        :     04.02.2003
-------------------------------------------------------------------------------------- */

Declare @iAux     integer
Declare @iTamOri  integer
Declare @iNx      integer
Declare @cNext    Char(01)
Declare @cSpace   Char(01)
Declare @cRef     VarChar(1)
Declare @cResult  VarChar(100)
Declare @iTamStr  integer

begin
   /*---------------------------------------------------------------------------------
     @IN_SOMAR é somado com '#', pois no SQLServer, mesmo que o parâmetro seja declarado
     como VarChar, qdo aplico a funçao Len numa var que contém '999 ' , a função Len 
     retorna 3 e não 4
     ---------------------------------------------------------------------------------*/
   select @iTamStr = ( Len( @IN_SOMAR + '#' ) - 1 )
   select @iTamOri = ( Len( @IN_SOMAR + '#' ) - 1 )
   select @iAux = 1
   select @iNx  = 1
   select @cRef = ' '
   select @cNext   = '0'
   select @cSpace  = '0'
   select @cResult = ' '
   
   If Len(Rtrim(@IN_SOMAR)) = 0 begin
      /*-----------------------------------------------------------------------
        @IN_SOMAR -> com tamanho zero
        -----------------------------------------------------------------------*/
      Exec MSSTRZERO @iAux, @iTamStr , @OUT_RESULTADO OutPut
   end
   else if @IN_SOMAR = Replicate( '*', @iTamOri) begin
      /*-----------------------------------------------------------------------
         @IN_SOMAR = '*********'
        -----------------------------------------------------------------------*/
      select @OUT_RESULTADO = @IN_SOMAR

   end
   else begin
      /*-----------------------------------------------------------------------
        @IN_SOMAR -> Cjto de Caracteres
        -----------------------------------------------------------------------*/
      While @iTamStr >= @iNx begin
         select @cRef = Substring(  @IN_SOMAR + '#' , @iTamStr , 1 )
         if @cRef = ' ' begin
            select @cResult = ' ' + @cResult
            select @cNext = '1'
            select @cSpace = '1'
         end
         else if @IN_SOMAR = ( Replicate('z',  @iTamOri )) begin
            select @cResult = ( Replicate('*',  @iTamOri ))
            break
         end
         else if @cRef < '9' begin
            select @cResult = Substring( @IN_SOMAR, 1, ( @iTamStr - 1) ) + Char( Ascii( @cRef ) + 1 ) + @cResult
            select @cNext = '0'
         end
         else if ( @cRef = '9' and @iTamStr > 1 ) begin
            If ( Substring( @IN_SOMAR,  @iTamStr - 1 ,1 ) <= '9'  and  Substring( @IN_SOMAR, @iTamStr - 1 ,1 ) <> ' ') begin
               select @cResult = '0' + @cResult
               select @cNext = '1'
            end
            else if ( Substring( @IN_SOMAR, ( @iTamStr -1 ), 1 ) = ' ' ) begin
               select @cResult = Substring( @IN_SOMAR,1,( @iTamStr - 2 ) ) + '10' + @cResult
               select @cNext = '0'
            end
            else begin
               select @cResult = Substring( @IN_SOMAR, 1, ( @iTamStr - 1 ) ) + 'A' + @cResult
               select @cNext = '0'
            end
         end
         else if @cRef = '9' and ( @iTamStr = 1 ) and ( @cSpace = '1' ) begin
            select @cResult = '10' + Substring( @cResult, 1, ( Len( @cResult + '#' ) - 1) )
            select @cNext = '0'
         end
         else if @cRef = '9' and @iTamStr = 1 and @cSpace = '0' begin
            select @cResult = 'A' + @cResult
            select @cNext ='0'
         end
         else if @cRef > '9' and @cRef < 'Z' begin
            select @cResult = Substring( @IN_SOMAR, 1, ( @iTamStr - 1 ) ) + Char( ( Ascii( @cRef )+ 1 ) ) + @cResult
            select @cNext = '0'
         end
         else if @cRef > 'Z' and @cRef < 'z' begin
            select @cResult = Substring( @IN_SOMAR, 1, ( @iTamStr - 1 )) + Char((Ascii( @cRef ) + 1)) + @cResult
            select @cNext = '0'
         end
         else if @cRef = 'Z' and @IN_SOMALOW = '1' begin
            select @cResult = Substring( @IN_SOMAR, 1, ( @iTamStr - 1 )) + 'a' + @cResult
            select @cNext = '0'
         end
         else if ( @cRef='z' or @cRef = 'Z') and @cSpace = '1' begin
            select @cResult = Substring( @IN_SOMAR, 1, @iTamStr ) + '0' + Substring( @cResult, 1, ( Len( @cResult +'#' ) - 2 ))
            select @cNext = '0'
         end
         else if @cRef = 'z' or @cRef = 'Z' begin
            select @cResult = '0' + @cResult
            select @cNext = '1'
         end
         if @cNext = '0' break
         select @iTamStr = @iTamStr - 1
      End
      select @OUT_RESULTADO = @cResult
   end
end

If OBJECT_ID('digitonfe') > 0
   DROP FUNCTION digitonfe
GO
CREATE FUNCTION digitonfe(@in_chvndig varchar(43))
Returns varchar(1)
As
Begin

   Declare @fpeso   varchar(43)
   Declare @i       integer
   Declare @j       integer
   Declare @fReturn VarChar(1)

   Set @fpeso = '4329876543298765432987654329876543298765432'

   Set @j = 0
   Set @i = 0
   Set @fReturn = 0
   While @i >= 43
   begin
      Set @j = @j + cast(substring(@in_chvndig, @i, 1) as integer) * cast(substring(@fpeso, @i, 1) as integer)

      if (@j % 11) < 2
         Set @fReturn = '0'
      else
         Set @fReturn = 11 - (@j % 11)
   end

   return @fReturn
End
GO