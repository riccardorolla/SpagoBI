/**
 * SpagoBI - The Business Intelligence Free Platform
 *
 * Copyright (C) 2004 - 2008 Engineering Ingegneria Informatica S.p.A.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 * 
 **/
package it.eng.spagobi.engines.qbe.worksheet.serializer.json;

import it.eng.qbe.serializer.IDeserializer;
import it.eng.qbe.serializer.SerializationException;
import it.eng.spagobi.engines.qbe.worksheet.WorkSheet;
import it.eng.spagobi.engines.qbe.worksheet.WorkSheetDefinition;
import it.eng.spagobi.utilities.assertion.Assert;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * @authors Alberto Ghedin (alberto.ghedin@eng.it)
 *
 */
public class WorkSheetJSONDeserializer implements IDeserializer {

    public static transient Logger logger = Logger.getLogger(WorkSheetJSONDeserializer.class);
    
	public WorkSheetDefinition deserialize(Object o) throws SerializationException {
		WorkSheetDefinition workSheetDefinition = null;
		JSONObject workSheetDefinitionJSON = null;
		
		logger.debug("IN");
		
		try {
			Assert.assertNotNull(o, "Object to be deserialized cannot be null");
			
			if(o instanceof String) {
				logger.debug("Deserializing string [" + (String)o + "]");
				try {
					workSheetDefinitionJSON = new JSONObject( (String)o );
				} catch(Throwable t) {
					logger.debug("Object to be deserialized must be string encoding a JSON object");
					throw new SerializationException("An error occurred while deserializing query: " + (String)o, t);
				}
			} else if(o instanceof JSONObject) {
				workSheetDefinitionJSON = (JSONObject)o;
			} else {
				Assert.assertUnreachable("Object to be deserialized must be of type string or of type JSONObject, not of type [" + o.getClass().getName() + "]");
			}
			
			workSheetDefinition  = new WorkSheetDefinition();
			
			try {
				deserializeSheets(workSheetDefinitionJSON, workSheetDefinition);
			} catch (Exception e) {
				throw new SerializationException("An error occurred while deserializing worksheet: " + workSheetDefinitionJSON.toString(), e);
			}

		} finally {
			logger.debug("OUT");
		}
		logger.debug("Worksheet deserialized");
		return workSheetDefinition;
	}
	
	/**
	 * Deserialize the list of sheets
	 * @param crosstabDefinitionJSON
	 * @param crosstabDefinition
	 * @throws Exception
	 */
	private void deserializeSheets(JSONObject crosstabDefinitionJSON, WorkSheetDefinition crosstabDefinition) throws Exception {
		JSONArray sheetsJSON = crosstabDefinitionJSON.getJSONArray(WorkSheetSerializationCostants.SHEETS);
		List<WorkSheet> workSheets = new ArrayList<WorkSheet>();
		for(int i=0; i<sheetsJSON.length(); i++){
			workSheets.add(deserializeSheet(sheetsJSON.getJSONObject(i)));
		}
		crosstabDefinition.setWorkSheet(workSheets);
	}
	
	/**
	 * Deserialize the Sheet
	 * @param sheetJSON
	 * @return
	 * @throws Exception
	 */
	private WorkSheet deserializeSheet(JSONObject sheetJSON) throws Exception {
		String name = sheetJSON.getString(WorkSheetSerializationCostants.NAME);
		JSONObject header = sheetJSON.optJSONObject(WorkSheetSerializationCostants.HEADER);
		JSONObject filters = sheetJSON.optJSONObject(WorkSheetSerializationCostants.FILTERS);
		JSONObject content = sheetJSON.optJSONObject(WorkSheetSerializationCostants.CONTENT);
		JSONObject footer = sheetJSON.optJSONObject(WorkSheetSerializationCostants.FOOTER);
		return new WorkSheet(name, header, filters, content, footer);
	}
	
		
}