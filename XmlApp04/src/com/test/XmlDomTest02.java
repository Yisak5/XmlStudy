/*============================================
	XmlDomTest01.java
	- 콘솔 기반 자바 프로그램
	- XML DOM 활용 → 로컬(local) XML 읽어내기
	  (memberList.xml)
============================================*/

package com.test;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class XmlDomTest02
{
	public static void main(String[] args)
	{
		// 김상기 010-1213-4546
		// 김민성 010-5678-6789
		
		try
		{
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document xmlObj = null;
			
			String url = "memberList.xml";
			xmlObj = builder.parse(url);
			
			Element root = xmlObj.getDocumentElement();
			
			NodeList memberNodeList = root.getElementsByTagName("memberInfo");
			
			for (int i = 0; i < memberNodeList.getLength(); i++)
			{
				Node memberNode = memberNodeList.item(i);
				//-- 『getElementsByTagName()』메소드가 이름을 통해 대상을 획득했다면...
				//	 『item()』메소드는 위치(인덱스)를 통해 대상을 획득하게 된다.
				
				// 캐스팅
				Element memberElement = (Element)memberNode;
				//-- 엘리먼트가 노드의 하위 개념이라 가능
				
				System.out.printf("%s %s%n"
						, getText(memberElement, "name")
						, getText(memberElement, "telephone"));
				//--==>>
				/*
				김상기 010-1213-4546 
				김민성 010-5678-6789 
				*/

				// 커리큘럼에 대한 처리 추가 ---------------------------------------------------
				
				// memberInfoElement 로 부터 curriculumn NodeList 얻어오기
				NodeList curriculumnNodeList = memberElement.getElementsByTagName("curriculumn");
				
				if (curriculumnNodeList.getLength() > 0)
				{
					Node curriculumnNode = curriculumnNodeList.item(0);
					Element curriculumnElement = (Element)curriculumnNode;
					
					// 방법 1.
					/*
					NodeList subNodeList = curriculumnElement.getElementsByTagName("sub");
					for (int m = 0; m < subNodeList.getLength(); m++)
					{
						Node subNode = subNodeList.item(m);
						Element subElement = (Element)subNode;
						System.out.printf("%s ", subElement.getTextContent());
					}
					System.out.println();
					*/
					
					// 방법 2.
					/*
					-------------------------------------------------------------
					Node Type			Named Constant
					-------------------------------------------------------------
					    1               ELEMENT_NODE
					    2				ATTRIBUTE_NODE
					    3				TEXT_NODE
					    4				CDATA_SECTION_NODE
					    5				ENTITY_REFERENCE_NODE				?
					    6				ENTITY_NODE							?
					    7				PROCESS_INSTRUCTION_NODE
					    8				COMMENT_NODE
					    9				DOCUMENT_NODE
					    10				DOCUMENT_TYPE_NODE
					    11				DOCUMENT_FRAGMENT_NODE
					    12				NOTATION_NODE
					-------------------------------------------------------------
					*/
					
					NodeList subNodeList = curriculumnElement.getChildNodes();		// check~!!!
					for (int m=0; m<subNodeList.getLength(); m++)
					{
						Node subNode = subNodeList.item(m);
						if (subNode.getNodeType() == 1) 	// ELEMENT_NODE			// check~!!!
						{
							Element subElement = (Element)subNode;
							System.out.printf("%s ", subElement.getTextContent());
						}
					}
					System.out.println();
					
					
				}
				
				
				
				// ----------------------------------------------------커리큘럼에 대한 처리 추가
				
				
				
			}
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
	}
	
	private static String getText(Element parent, String tagName)
	{
		String result = "";
		
		Node node = parent.getElementsByTagName(tagName).item(0);
		Element element = (Element)node;
		
		result = element.getChildNodes().item(0).getNodeValue();
		
		return result;
		
	}

}
