Do{ Do {   
    $entrycpf = Read-Host("Insira o CPF`n(ex: 123.123.123-12 ou 12312312312): ")
    [System.Media.SystemSounds]::Beep.Play(); 
 } while($entrycpf.Length -lt 11 -or ($entrycpf -gt 11 -and ($entrycpf -notmatch "." -and $entrycpf -notmatch "-")))
$CPF =  $entrycpf.Replace(".","").Replace("-","").Replace(" ","").Trim(" ")
$CPF_UMASK = $CPF.SubString(0,3)+$CPF.SubString(3,3)+$CPF.SubString(6,3)+$CPF.SubString(9,2)
$array = New-Object System.Collections.Generic.List[System.Object]
foreach($number in ($CPF_UMASK.ToCharArray())){
        $array.add([int]::parse($number))
}
$digit1 = 0
$digit2 = 0
$x = 0
$dv = 10
$CPFLast = $array[($CPF_UMASK.length-1)]
$CPFPenum = $array[($CPF_UMASK.length-2)]
while($x -lt ($CPF_UMASK.length-2)){
    $calc = $array[$x]*$dv
    [int]$digit1 = $digit1+$calc
    $x = $x+1
    $dv = $dv-1
}
$validator1 = $digit1 % 11
if($validator1 -lt 2){
    $v1_digit = 0
}else{
    $v1_digit = (11 - $validator1)
}

$x = 1
$dv = 10

while($x -lt ($CPF_UMASK.length-2)){
    $calc = $array[$x]*$dv
    [int]$digit2 = $digit2+$calc
    $x = $x+1
    $dv = $dv-1
}
$calc=$v1_digit*2
$digit2 = $digit2+$calc
[int]$validator2 = $digit2 % 11
if($validator2 -lt 2){
    $v2_digit = 0
}else{
    $v2_digit = (11 - $validator2)
}
if($v1_digit -match $CPFPenum -and $v2_digit -match $CPFLast ){
    Write-Host (" CPF Válido")
    $a = Read-host("Deseja validar outro CPF? `n(1) Sim`t| (2) Não ")
    while($a -gt 2 -or $a -lt 1 ){
        $a = Read-host("Opção Inválida. Deseja validar outro CPF? `n(1) Sim`t| (2) Não ")
    }
}
else{
    Write-Host ("CPF Inválido")
    $a = Read-host("Deseja validar outro CPF? `n(1) Sim`t| (2) Não ")
    while($a -gt 2 -or $a -lt 1 ){
        $a = Read-host("Opção Inválida. Deseja validar outro CPF? `n(1) Sim`t| (2) Não ")
    }
}}while($a -ne 2) 