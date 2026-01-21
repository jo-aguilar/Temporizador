#!/usr/bin/env raku

proto sub erro_formato(){*};

sub MAIN(Str $Entrada1){
	my $CHAR_MAX = 6;
	my Str $Entrada = $Entrada1;
	if ($Entrada1 eq "ajuda") {
		say qq:to/END/;

		[!!!] Uso: ./{$*PROGRAM} <argumento>
		      [!] <argumento> deve conter somente números, sendo 
		      sua interpretação numérica máxima 235959 (lida
		      pelo sistema como 23:59:59)
		END
		return;
	}
	if ($Entrada.chars() > $CHAR_MAX) {
		say q:to/END/;
		[!!!] ERRO: Entrada com quantidade excessiva de elementos.
		      Máximo de elementos da string: 6.
		      Terminando...
		END
		return;
	}
	else{
		if ($Entrada.chars() < $CHAR_MAX ) {
			$Entrada = '0' x ($CHAR_MAX - $Entrada.chars()) ~ $Entrada; 
			say $Entrada;
		}
		my Bool $check = so $Entrada.comb.all ~~ /\d/;
		if ($check == False) {
			erro_formato();
			return;
		}
		elsif ($check == True) {
			my ($horas, $minutos, $segundos) = $Entrada.comb(2);
			if (!($horas.Int (elem) (0..23)) or 
			    !($minutos.Int (elem) (0..59)) or
			    !($segundos.Int (elem) (0..59))) {
				erro_formato();
				return;
			}
			else {
				#Contagem regressiva com correção do relógio
				loop (my $h = $horas.Int; $h >=0; $h--){
					loop (my $m = $minutos.Int; $m >= 0; $m--){
						#if ($m==0 and $h>0) {$m=59;}
						
						loop (my $s = $segundos.Int; $s >= 0; $s--){
							if ($m==0 and $s == 0 and  $h>0) { $m=60; $h--;}
							if ($s==0 and $m>0) { $s=59; $m--;}
							
							shell('clear');
							say $h.fmt('%02d') ~ ":" ~ 
							    $m.fmt('%02d') ~ ":" ~ 
							    $s.fmt('%02d');
							sleep(1);
						}
					}
				}
				for 1..10 {
					print("\a"); #chamada do sino
					sleep(1.1);
				}
			}
		}
	}
}

multi sub erro_formato () {
	say q:to/END/;
	[!!!] ERRO: Má formatação de entrada.
	      Entradas devem ser somente números, devem
	      ser 6 caracteres e pares devem respeitar
	      HR/MI/SC (horas, minutos, segundos) em 
	      formato de 00~59.
	      Terminando...
	END
}
