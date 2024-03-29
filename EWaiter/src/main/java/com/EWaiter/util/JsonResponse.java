package com.EWaiter.util;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;



public class JsonResponse {
	public JsonResponse(ErrorCode code) {
		this.msg = code.getDetail();
	}
	
	public JsonResponse(ErrorCode code, JSONObject data) {
		this.msg = code.getDetail();
		this.data = data;
	}
	
	public JsonResponse(String message) {
		this.msg = message;
	}
	
	public JsonResponse(ErrorCode code, String detail) {
		this.msg = String.format("%s: %s", code.getDetail(), detail);
	}
	
	public JsonResponse(ErrorCode code, String detail, JSONObject data) {
		this.msg = String.format("%s: %s", code.getDetail(), detail);
		this.data = data;
	}

	public String generate() {
		try {
			result.put("msg", msg);
			result.put("data", data);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return result.toString();
	}
	
	private String msg = "";
	private JSONObject data = new JSONObject();
	private JSONObject result = new JSONObject();
	
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public JSONObject getData() {
		return data;
	}
	public void setData(JSONObject data) {
		this.data = data;
	}
}
