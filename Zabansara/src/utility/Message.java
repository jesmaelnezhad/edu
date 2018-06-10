/**
 * 
 */
package utility;

/**
 * @author jam
 *
 */
public class Message {

	public String color;
	public String message;
	public Message(String message){
		this.message = message;
		this.color = "red";		
	}
	public Message(String message, String color){
		this.message = message;
		this.color = color;
	}
}
