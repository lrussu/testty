<?php
    # Arabic
    $jsonFile = file_get_contents('./testty_localization/ar.json');
    $json = json_decode($jsonFile);
    
    $ios_strings = "";
    $ios_info_plist = "";
    $notDefinedAppName = TRUE;
    
    foreach ($json as $key=>$value) {
        
        if ($notDefinedAppName AND $key == 'app_name') {
            $ios_info_plist .='"CFBundleDisplayName" = "'.$value.'";'.PHP_EOL;
            $ios_info_plist .='"CFBundleName" = "'.$value.'";'.PHP_EOL;
            file_put_contents('./testty/ar.lproj/InfoPlist.strings', $ios_info_plist);
            $notDefinedAppName = false;
            continue;
        };
        
        $ios_strings.='"'.$key.'" = "'.str_replace('%s', '%@', str_replace('"','\"', str_replace("\n", '\n', $value))).'";'.PHP_EOL;
    }
    $ios_strings = preg_replace('/(\\\\)(u)(\d{4})/', '$1U$3', $ios_strings);
    file_put_contents('./testty/ar.lproj/Localizable.strings', $ios_strings);
    
    # Russian
    $jsonFile = file_get_contents('./testty_localization/ru.json');
    $json = json_decode($jsonFile);
    
    $ios_strings = ""; 
    $ios_info_plist = "";
    $notDefinedAppName = TRUE;
    foreach ($json as $key=>$value) {
        if ($notDefinedAppName AND $key == 'app_name') {
            $ios_info_plist .='"CFBundleDisplayName" = "'.$value.'";'.PHP_EOL;
            $ios_info_plist .='"CFBundleName" = "'.$value.'";'.PHP_EOL;
            file_put_contents('./testty/ru.lproj/InfoPlist.strings', $ios_info_plist);
            $notDefinedAppName = false;
            continue;
        };
        
        $ios_strings.='"'.$key.'" = "'.str_replace('%s', '%@', str_replace('"','\"', str_replace("\n", '\n', $value))).'";'.PHP_EOL;
    }
    $ios_strings = preg_replace('/(\\\\)(u)(\d{4})/', '$1U$3', $ios_strings);
    file_put_contents('./testty/ru.lproj/Localizable.strings', $ios_strings);
    
    # English
    $jsonFile = file_get_contents('./testty_localization/en.json');
	$json = json_decode($jsonFile);
	
	$ios_strings = "";
    $ios_info_plist = "";
    $notDefinedAppName = TRUE;
	foreach ($json as $key=>$value)
	{
        if ($notDefinedAppName AND $key == 'app_name') {
            $ios_info_plist .='"CFBundleDisplayName" = "'.$value.'";'.PHP_EOL;
            $ios_info_plist .='"CFBundleName" = "'.$value.'";'.PHP_EOL;
            file_put_contents('./testty/Base.lproj/InfoPlist.strings', $ios_info_plist);
            $notDefinedAppName = false;
            continue;
        };
        
        $ios_strings.='"'.$key.'" = "'.str_replace('%s', '%@', str_replace('"','\"', str_replace("\n", '\n', $value))).'";'.PHP_EOL;
	}
	$ios_strings = preg_replace('/(\\\\)(u)(\d{4})/', '$1U$3', $ios_strings);
	file_put_contents('./testty/Base.lproj/Localizable.strings', $ios_strings);
	$ios_swift_strings = 'import Foundation'.PHP_EOL.PHP_EOL.'extension String {'.PHP_EOL;
	foreach ($json as $key=>$value)
	{
		$value_without_linefeed = preg_replace("/\r|\n/", " ", $value);
		$ios_swift_strings .= "\t/// ".$value_without_linefeed."\n\t".'static let '.preg_replace_callback('/_(.?)/', function ($m) { return strtoupper($m[1]); }, $key).' = "'.$key.'".localized()'."\n".PHP_EOL;
	}
	$ios_swift_strings .= '}'.PHP_EOL;
	file_put_contents('./testty/String+Localization.swift', $ios_swift_strings);
?>
