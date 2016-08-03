import org.exolab.castor.mapping.Mapping;
import org.exolab.castor.mapping.MappingException;
import org.exolab.castor.xml.Unmarshaller;
import org.exolab.castor.xml.Marshaller;

import java.io.IOException;
import java.io.FileReader;
import java.io.OutputStreamWriter;

import org.xml.sax.InputSource;

public class test {

    public static void main(String args[]) {
        Mapping mapping = new Mapping();

        try {
            // 1. Load the mapping information from the file
            mapping.loadMapping( "mapping.xml" );

            // 2. Unmarshal the data
            Furniture furn= new Furniture();
            
            // 4. marshal the data with the total price back and print the XML in the console
            Marshaller marshaller = new Marshaller(new OutputStreamWriter(System.out));
            marshaller.setMapping(mapping);
            marshaller.marshal(furn);

        } catch (Exception e) {
            System.out.println(e);
            return;
        }
    }
}
            

