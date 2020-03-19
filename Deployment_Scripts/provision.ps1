
#.\provision.ps1 "1ce173c3-3aa5-4be7-b56a-df713a39939c" "3ge4GubZnqeghnC0oMTRf9lf.oEe.B]/" "350d072b-d849-4df7-93bf-d5593556851d" "..\ADFCode" "DataMov" "DataMoveWithRepoLink"
param(
    [Parameter(Mandatory=$true)]
    $SPNApplicationId,
    
    [Parameter(Mandatory=$true)]
    $SPNclientsec,

    [Parameter(Mandatory=$true)]
    $SPNtenant,

    [Parameter(Mandatory=$true)]
    $Path,

    [Parameter(Mandatory=$true)]
    $ResourceGroupName,

    [Parameter(Mandatory=$true)]
    $DataFactoryName
)
try
{
    $cred =  $SPNclientsec | ConvertTo-SecureString -AsPlainText -Force
    $Credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $SPNApplicationId, $cred #$clientId, $cred
    Connect-AzAccount -Credential $Credential -ServicePrincipal -Tenant $SPNtenant  
  
    Write-Output "this is the path start value $Path"
    Write-Output "Path complete to the code "

    # Get data factory
    Write-Output -Message "Connecting to Data Factory '$DataFactoryName'."
    #$dataFactory = Get-AzureRmDataFactory -ResourceGroupName $ResourceGroupName -Name $DataFactoryName
    $dataFactory =   Get-AzDataFactoryV2 -ResourceGroupName $ResourceGroupName -Name $DataFactoryName




    #Remove data factory artefact that  exist
    Get-ChildItem -Path "$Path\pipeline" | Sort-Object | % {
        Write-Output  -Message "Removing pipeline from file $($_.FullName)."
        try {
            $filename = $_.FullName
            $pipeline =  Get-AzDataFactoryV2Pipeline -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $($_.BaseName)

            if ($pipeline)
            {
                 Remove-AzDataFactoryV2Pipeline -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $($_.BaseName) -Force 
                 Write-Output -Message "Removed Pipeline $($_.FullName)."
            }          
        }
        catch {
            Write-Output -Message "Error deleting pipeline from file '$filename': $($_.Exception.Message)." -MessageType error
        }
        
    }

    Get-ChildItem -Path "$Path\dataset" | Sort-Object | % {
        Write-Output -Message "Creating dataset from file $($_.FullName)."
        try {
            $filename = $_.FullName
            $dataset =  Get-AzDataFactoryV2Dataset -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $($_.BaseName)

            if ($dataset)
            {
                 Remove-AzDataFactoryV2Dataset -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $($_.BaseName) -Force 
                 Write-Output -Message "Removed dataset $($_.FullName)."
            } 
        }
        catch {
            Write-Output -Message "Error deleting dataset from file '$filename': $($_.Exception.Message)." -MessageType error
        }
    }

    Get-ChildItem -Path "$Path\LinkedService" | Sort-Object | % {
        Write-Output -Message "Creating linked service from file $($_.FullName)."
        try {
            $linkedService =   Get-AzDataFactoryV2LinkedService -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $($_.BaseName)
            if ($linkedService)
            {
                 Remove-AzDataFactoryV2LinkedService -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $($_.BaseName) -Force 
                 Write-Output -Message "Removed Linked Service $($_.FullName)."
            }
            Write-Output -Message "Removed linked service from file $($_.FullName)."
        }
        catch {
            Write-Output -Message "Error deleting linked service from file '$filename': $($_.Exception.Message)." -MessageType error
        }        
    }


    # Create objects
    Get-ChildItem -Path "$Path\LinkedService" | Sort-Object | % {
        Write-Output -Message "Creating linked service from file $($_.FullName)."
        try {          
            Set-AzDataFactoryV2LinkedService -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $($_.BaseName) -File $($_.FullName) -Force | Format-List            
            Write-Output -Message "Created linked service from file $($_.FullName)."
        }
        catch {
            Write-Output -Message "Error creating linked service from file '$filename': $($_.Exception.Message)." -MessageType error
        }
        
    }

    Get-ChildItem -Path "$Path\dataset" | Sort-Object | % {
        Write-Output -Message "Creating dataset from file $($_.FullName)."
        try {
            $filename = $_.FullName
            Set-AzDataFactoryV2Dataset -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $($_.BaseName) -File $($_.FullName) -Force | Format-List            
            Write-Output -Message "Created dataset from file $($_.FullName)."
        }
        catch {
            Write-Output -Message "Error creating dataset from file '$filename': $($_.Exception.Message)." -MessageType error
        }
    }

    Get-ChildItem -Path "$Path\pipeline" | Sort-Object | % {
        Write-Output  -Message "Creating pipeline from file $($_.FullName)."
        try {
            $filename = $_.FullName
            Set-AzDataFactoryV2Pipeline -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $($_.BaseName) -File $($_.FullName) -Force | Format-List            
            Write-Output -Message "Created pipeline from file $($_.FullName)."
        }
        catch {
            Write-Output -Message "Error creating pipeline from file '$filename': $($_.Exception.Message)." -MessageType error
        }
        
    }
}
catch
{
    throw
}
