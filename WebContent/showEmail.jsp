<%--
 Copyright (C) 2009  HungryHobo@mail.i2p
 
 The GPG fingerprint for HungryHobo@mail.i2p is:
 6DD3 EAA2 9990 29BC 4AD2 7486 1E2C 7B61 76DC DC12
 
 This file is part of I2P-Bote.
 I2P-Bote is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 I2P-Bote is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with I2P-Bote.  If not, see <http://www.gnu.org/licenses/>.
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ib" uri="I2pBoteTags" %>

<c:set var="email" value="${ib:getEmail(param.folder, param.messageID)}"/>

<ib:setEmailRead folder="${ib:getMailFolder(param.folder)}" messageId="${param.messageID}" read="true"/>

<jsp:include page="header.jsp">
    <jsp:param name="title" value="${email.subject}"/>
</jsp:include>

<div class="main">
    <table>
        <tr>
            <td valign="top"><strong>From:</strong></td>
            <td><ib:address address="${email.sender}"/></td>
        </tr>
        <tr>
            <td valign="top"><strong>To:</strong></td>
            <td>
                <c:forEach var="recipient" varStatus="status" items="${email.allRecipients}">
                    <ib:address address="${recipient}"/>
                    <c:if test="${!status.last}">,<p/></c:if>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <td valign="top"><strong>Subject:</strong></td>
            <td>${email.subject}</td>
        </tr>
        <tr>
            <td valign="top"><strong>Message:</strong></td>
            <td><ib:formatPlainText text="${email.bodyText}"/></td>
        </tr>
        <tr>
            <td colspan="2">
                <table><tr>
                    <td>
                    <form action="newEmail.jsp" method="post">
                        <button type="submit">Reply</button>
                        <input type="hidden" name="sender" value="${ib:getOneLocalRecipient(email)}"/>
                        <input type="hidden" name="recipient0" value="${email.sender}"/>
                        <input type="hidden" name="subject" value="Re: ${email.subject}"/>
                        <input type="hidden" name="quoteMsgFolder" value="${param.folder}"/>
                        <input type="hidden" name="quoteMsgId" value="${param.messageID}"/>
                    </form>
                    </td><td>
                    <form action="deleteEmail.jsp" method="post">
                        <button type="submit">Delete</button>
                        <input type="hidden" name="folder" value="${param.folder}"/>
                        <input type="hidden" name="messageID" value="${email.messageID}"/>
                    </form>
                    </td>
                </tr></table>
            </td>
        </tr>
    </table>
</div>

<jsp:include page="footer.jsp"/>