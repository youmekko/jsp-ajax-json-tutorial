package ajax.user;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserSearchServlet")
public class UserSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		response.setContentType("text/html; charset=UTF-8");
		String userName = request.getParameter("userName");
		response.getWriter().write(getJSON(userName));

	}

	public String getJSON(String userName) {

		if (userName == null)
			userName = "";

		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");

		UserDAO dao = new UserDAO();
		ArrayList<User> list = dao.search(userName);
		for (int i = 0; i < list.size(); i++) {
			result.append("[{\"value\": \"" + list.get(i).getUserName() + "\"},");
			result.append("{\"value\": \"" + list.get(i).getUserAge() + "\"},");
			result.append("{\"value\": \"" + list.get(i).getUserGender() + "\"},");
			result.append("{\"value\": \"" + list.get(i).getUserEmail() + "\"}],");
		}

		result.append("]}");

		System.out.println(result.toString());
		return result.toString();
	}

}
