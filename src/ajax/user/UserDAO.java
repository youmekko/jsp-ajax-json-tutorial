package ajax.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import ajax.dbconnector.DBConnection;

public class UserDAO {

	public ArrayList<User> search(String userName) {
		String sql = "SELECT * FROM user WHERE userName LIKE ?";

		ArrayList<User> list = new ArrayList<User>();

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {

			conn = DBConnection.connect();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, "%" + userName + "%");

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				User user = new User();
				user.setUserName(rs.getString(1));
				user.setUserAge(rs.getInt(2));
				user.setUserGender(rs.getString(3));
				user.setUserEmail(rs.getString(4));

				list.add(user);

			}

		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException se) {
			}
		}

		return list;
	}

	public int register(User user) {
		int result = 0;

		String sql = "INSERT INTO user values (?, ?, ?, ?)";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {

			conn = DBConnection.connect();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user.getUserName());
			pstmt.setInt(2, user.getUserAge());
			pstmt.setString(3, user.getUserGender());
			pstmt.setString(4, user.getUserEmail());

			result = pstmt.executeUpdate();

		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}

		return result;
	}

}
