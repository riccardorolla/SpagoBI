 

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
     String PatientID = request.getParameter("PatientID");
     String AccessionNumber = request.getParameter("AccessionNumber");
     String Username = request.getParameter("Username");
     String Report = request.getParameter("Report");
%>
<!DOCTYPE html>
<%
    response.sendRedirect("/servlet/AdapterHTTP?ACTION_NAME=EXECUTE_DOCUMENT_ACTION&NEW_SESSION=TRUE&"+
            "OBJECT_LABEL=" + Report +
            "&PARAMETERS=" +  
            ((PatientID!=null)?"P_PATIENT_ID%3D"+ PatientID + "%26":"")+
            ((Username!=null)?"P_USER_NAME%3D"+ Username +"%26":"")+
            ((AccessionNumber!=null)?"P_ACC_NUMBER%3D"+AccessionNumber:""));
%>
