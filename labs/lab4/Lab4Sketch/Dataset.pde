import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.URL;
import org.apache.commons.csv.CSVFormat;
import java.io.Reader;
import java.util.List;
import java.util.Map;


public class Dataset {

  List<String>  names;
  List<Integer> numbers;
  
  public Dataset(String url){
    names   = new ArrayList<String>();
    numbers = new ArrayList<Integer>();
    try {
      InputStream input = new URL(url).openStream();
      Reader r = new InputStreamReader(input);
      Iterable<CSVRecord> records = CSVFormat.EXCEL.withHeader().parse(r);
      for (CSVRecord record : records) {
        try {
          numbers.add(Integer.parseInt(record.get("Number")));
        } catch (NumberFormatException e){
          println(e);
          numbers.add(0);
        }
        names.add(record.get("Name"));
      }
    } catch (Exception e){
      println(e);
    }
  }
  
  public List<String> getNames(){
    return names;
  }
  
  public List<Integer> getNumbers(){
    return numbers;
  }
  
  public int getMax(){
    int max = Integer.MIN_VALUE;
    for (Integer n : numbers){
      if (n > max) max = n;
    }
    return max;
  }
  
  public Map<String, List<Integer>> groupNumbersByName(){
    Map<String, List<Integer>> m = new HashMap<String, List<Integer>>();
    for (int i=0; i < names.size(); i++){
      String  name   = names.get(i);
      Integer number = numbers.get(i);
      
      if (!m.containsKey(name)) 
        m.put(name, new ArrayList<Integer>());
      
      m.get(name).add(number);
    }
    return m;
  }
  
  public Map<Integer, List<String>> groupNamesByNumber(){
    Map<Integer, List<String>> m = new HashMap<Integer, List<String>>();
    for (int i = 0; i < names.size(); i++){
      String  name   = names.get(i);
      Integer number = numbers.get(i);
      
      if (!m.containsKey(number)) 
        m.put(number, new ArrayList<String>());
      
      m.get(number).add(name);
    }
    return m;
  }


}
