public class currencyConverterController 
{
	@AuraEnabled(cacheable=true)//missing cacheable as to save runtime its required
    public double getConversion(String amount, String convertFrom, String convertTo)
    {
        
        Http http = new Http()
        HttpRequest req = new HttpRequest();//missing semicolon
        String endpoint = 'https://api.exchangerate.host/convert?from='+convertFrom + '&to=' + convertTo + '&amount='+amount;
        req.setEndpoint(endpoint);
        setMethod('GET');
        HttpResponse res = http.send(req); //missing semicolon
        map<String, Object> responseMap = new map<String, Object>();
        if(res.getStatusCode() != 200) 
        {
            System.debug('The status code returned was not expected: ' + res.getStatusCode() + ' ' + res.getStatus());
        }
        else 
        {
            System.debug('Response--> '+ res.getBody());
            responseMap = (map<String, Object>) JSON.deserializeUntyped(res.getBody());
            System.debug('result--> '+responseMap.get('result'));
        }
        return (Double)responseMap.get('result');
    }
    
    @AuraEnabled(cacheable=true)
    public static <String, Object> getCodes()
    {
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.exchangerate.host/symbols');
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        map<String, Object> responseMap = new map<String, Object>();
        if(res.getStatusCode() != 200)
        {
            System.debug('The status code returned was not expected: ' + res.getStatusCode() + ' ' + res.getStatus());
        }
        else
        {
            responseMap = (map<String, Object>) JSON.deserializeUntyped(res.getBody());
        }
        map<String, Object> symbolMap = (map<String, Object>)(responseMap.get('symbols'));
        System.debug('symbolMap--> '+symbolMap);	
        return symbolMap;
    }
}
