/*============================================
	XmlDomTest04.java
	- 콘솔 기반 자바 프로그램
	- XML DOM 활용 → 로컬(local) XML 읽어내기
	  (breakfast_menu.xml)
============================================*/

package com.test;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class XmlDomTest04
{
	public static void main(String[] args)
	{
		/*
		----------------------------------------------------
		NO  MAKE   MODEL     YEAR   STYLE           PRICE
		----------------------------------------------------
		1   Dodge  Durango   1998   Sport Utility   18000
		Options --------------------------------------------
		   	Power_Locks : Yes
		   	Power_Window : Yes
		   	Stereo : Radio/Cassette/CD
		   	Air_Conditioning : Yes
		   	Automatic : Yes
		   	Four_Wheel_Drive : Full/Partial
		   	Note : Very clean
		----------------------------------------------------
		2	Honda  Civic	 1997	Sedan			8000
		Options --------------------------------------------
		   	Power_Locks : Yes
		   	Power_Window : Yes
		   	Stereo : Radio/Cassette
		   	Automatic : Yes
		   	Note : Like New
		----------------------------------------------------
		3					：
		
		*/
		System.out.println("----------------------------------------------------");
		System.out.println("NO   MAKE       MODEL   YEAR      STYLE       PRICE");
		System.out.println("----------------------------------------------------");
		
		try
		{
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document xmlObj = null;
			
			String url = "VEHICLES.xml";
			xmlObj = builder.parse(url);
			
			Element rootElement = xmlObj.getDocumentElement();
			
			NodeList vehiclesNodeList = rootElement.getElementsByTagName("VEHICLE");
			
			for (int i = 0; i < vehiclesNodeList.getLength(); i++)
			{
				Node vehiclesNode = vehiclesNodeList.item(i);
				Element vehiclesElement = (Element)vehiclesNode;
				
				System.out.printf("%2s  %3s   %10s %5s %13s     %7s%n"
								, vehiclesElement.getElementsByTagName("INVENTORY_NUMBER").item(0).getTextContent()
								, vehiclesElement.getElementsByTagName("MAKE").item(0).getTextContent()
								, vehiclesElement.getElementsByTagName("MODEL").item(0).getTextContent()
								, vehiclesElement.getElementsByTagName("YEAR").item(0).getTextContent()
								, vehiclesElement.getElementsByTagName("STYLE").item(0).getTextContent()
								, vehiclesElement.getElementsByTagName("PRICE").item(0).getTextContent());
				
				// Option 추가
				System.out.println("Options --------------------------------------------");
				
				NodeList options = vehiclesElement.getElementsByTagName("OPTIONS");
				Node option = options.item(0);
				Element optionElement = (Element)option;
				
				NodeList childNodes = optionElement.getChildNodes();		// -- check~!!!
				for (int j = 0; j < childNodes.getLength(); j++)
				{
					Node childNode = childNodes.item(j);
					if (childNode.getNodeType() == 1)		// ELEMENT_NODE	// -- check~!!!
					{
						System.out.printf("       %s : %s%n"
										, childNode.getNodeName()			// -- check~!!!
										, childNode.getTextContent());
					}
					
				}
				
				System.out.println("----------------------------------------------------");
				
			}
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
	}
	
}
