param ([Parameter(Mandatory)]$sourcefile, $BatchSize = 50000)
$BatchSize = $BatchSize + 1

Import-Csv -Path $sourcefile |
    ForEach-Object -Begin
        {
            $Index = 0
        }
    -Process
        {
            if ($Index % $BatchSize -eq 0)
                {
                    $BatchNr = [math]::Floor($Index++ / $BatchSize)
                    $BatchStr = ($BatchNr + 1).ToString('000')
                    $tagetfile = $sourcefile.Replace('.csv', ('_' + $BatchStr + '.csv'))
                    $Pipeline = { Export-Csv -notype -Path $tagetfile }.GetSteppablePipeline()
                    $Pipeline.Begin($True)
                }

            $Pipeline.Process($_)
            if ($Index++ % $BatchSize -eq 0)
                {
                    $Pipeline.End()
                }
        }
    -End
        {
            $Pipeline.End()
        }

