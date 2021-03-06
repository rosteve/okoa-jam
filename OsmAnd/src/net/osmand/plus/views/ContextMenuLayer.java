package net.osmand.plus.views;

import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.PointF;
import android.graphics.Rect;
import android.os.Build;
import android.text.Html;
import android.view.GestureDetector;
import android.view.Gravity;
import android.view.MotionEvent;
import android.widget.FrameLayout.LayoutParams;
import android.widget.ImageView;
import android.widget.TextView;

import net.osmand.CallbackWithObject;
import net.osmand.data.LatLon;
import net.osmand.data.PointDescription;
import net.osmand.data.RotatedTileBox;
import net.osmand.plus.ContextMenuAdapter;
import net.osmand.plus.R;
import net.osmand.plus.activities.MapActivity;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

public class ContextMenuLayer extends OsmandMapLayer {
	
	public interface IContextMenuProvider {

		public void collectObjectsFromPoint(PointF point, RotatedTileBox tileBox, List<Object> o);
		
		public LatLon getObjectLocation(Object o);
		
		public String getObjectDescription(Object o);
		
		public PointDescription getObjectName(Object o);

		public boolean disableSingleTap();
		
		public boolean disableLongPressOnMap();
	}
	
	public interface IContextMenuProviderSelection {

		public void setSelectedObject(Object o);
		
		public void clearSelectedObjects();
		
	}
	
	private static final String KEY_LAT_LAN = "context_menu_lat_lon";
	private static final String KEY_DESCRIPTION = "context_menu_description";
	private static final String KEY_SELECTED_OBJECTS = "context_menu_selected_objects";
	private LatLon latLon;
	private String description;
	private Map<Object, IContextMenuProvider> selectedObjects = new ConcurrentHashMap<Object, IContextMenuProvider>();

	private TextView textView;
	private ImageView closeButton;
	private OsmandMapTileView view;
	private int BASE_TEXT_SIZE = 170;
	
	private final MapActivity activity;
	private float scaleCoefficient = 1;
	private CallbackWithObject<LatLon> selectOnMap = null;

	private boolean showContextMarker;
	private ImageView contextMarker;

	private GestureDetector movementListener;

	public ContextMenuLayer(MapActivity activity){
		this.activity = activity;
		movementListener = new GestureDetector(activity, new MenuLayerOnGestureListener());
		if(activity.getLastNonConfigurationInstanceByKey(KEY_LAT_LAN) != null) {
			latLon = (LatLon) activity.getLastNonConfigurationInstanceByKey(KEY_LAT_LAN);
			description = (String) activity.getLastNonConfigurationInstanceByKey(KEY_DESCRIPTION);
			if(activity.getLastNonConfigurationInstanceByKey(KEY_SELECTED_OBJECTS) != null) {
				selectedObjects = (Map<Object, IContextMenuProvider>) activity.getLastNonConfigurationInstanceByKey(KEY_SELECTED_OBJECTS);
			}
		}
	}
	
	@Override
	public void destroyLayer() {
	}
	
	public Object getFirstSelectedObject() {
		if(!selectedObjects.isEmpty()) {
			return selectedObjects.keySet().iterator().next();
		}
		return null;
	}

	@Override
	public void initLayer(OsmandMapTileView view) {
		this.view = view;
		scaleCoefficient  = view.getDensity();
		BASE_TEXT_SIZE = (int) (BASE_TEXT_SIZE * scaleCoefficient);
		textView = new TextView(view.getContext());
		LayoutParams lp = new LayoutParams(BASE_TEXT_SIZE, LayoutParams.WRAP_CONTENT);
		textView.setLayoutParams(lp);
		textView.setTextSize(15);
		textView.setTextColor(Color.argb(255, 0, 0, 0));
		textView.setMinLines(1);
//		textView.setMaxLines(15);
		textView.setGravity(Gravity.CENTER_HORIZONTAL);
		
		textView.setClickable(true);
		
		textView.setBackgroundDrawable(view.getResources().getDrawable(R.drawable.box_free));
		textView.setTextColor(Color.WHITE);
		
		closeButton = new ImageView(view.getContext());
		lp = new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
		closeButton.setLayoutParams(lp);
		closeButton.setImageDrawable(view.getResources().getDrawable(R.drawable.headliner_close));
		closeButton.setClickable(true);

		showContextMarker = false;
		contextMarker = new ImageView(view.getContext());
		contextMarker.setLayoutParams(new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT));
		contextMarker.setImageDrawable(view.getResources().getDrawable(R.drawable.map_pin_context_menu));
		contextMarker.setClickable(true);
		int minw = contextMarker.getDrawable().getMinimumWidth();
		int minh = contextMarker.getDrawable().getMinimumHeight();
		contextMarker.layout(0, 0, minw, minh);

		if(latLon != null){
			setLocation(latLon, description);
		}
		
	}
	

	public boolean isVisible() {
		return latLon != null;
	}
	
	@Override
	public void onDraw(Canvas canvas, RotatedTileBox box, DrawSettings nightMode) {
		if(latLon != null){
			int x = (int) box.getPixXFromLatLon(latLon.getLatitude(), latLon.getLongitude());
			int y = (int) box.getPixYFromLatLon(latLon.getLatitude(), latLon.getLongitude());

			if (showContextMarker) {
				canvas.translate(x - contextMarker.getWidth() / 2, y - contextMarker.getHeight());
				contextMarker.draw(canvas);
			}

			textView.setTextColor(nightMode != null && nightMode.isNightMode() ? Color.GRAY : Color.WHITE);
			if (textView.getText().length() > 0) {
				canvas.translate(x - textView.getWidth() / 2, y - textView.getHeight());
				int c = textView.getLineCount();
				
				textView.draw(canvas);
				//textView.getHeight() - closeButton.getHeight()
				canvas.translate(textView.getWidth() - closeButton.getWidth(), 0);
				closeButton.draw(canvas);
				if (c == 0) {
					// special case relayout after on draw method
					layoutText();
					view.refreshMap();
				} else if (c == 1) {
					// make 2 line description
					String des = textView.getText() + "\n ";
					textView.setText(des);
					layoutText();
					view.refreshMap();
				}
			}
		}
	}
	
	
	public void setSelectOnMap(CallbackWithObject<LatLon> selectOnMap) {
		hideMapContextMenuMarker();
		this.selectOnMap = selectOnMap;
	}
	
	
	private void layoutText() {
		Rect padding = new Rect();
		if (textView.getLineCount() > 0) {
			textView.getBackground().getPadding(padding);
		}
		int w = BASE_TEXT_SIZE;
		int h = (int) ((textView.getPaint().getTextSize() * 1.3f) * textView.getLineCount());
		
		textView.layout(0, 0, w, h + padding.top + padding.bottom);
		int minw = closeButton.getDrawable().getMinimumWidth();
		int minh = closeButton.getDrawable().getMinimumHeight();
		closeButton.layout(0, 0, minw, minh);
	}

	public void showMapContextMenuMarker() {
		showContextMarker = true;
		view.refreshMap();
	}

	public void showMapContextMenuMarker(LatLon latLon) {
		activity.getContextMenu().hide();
		this.latLon = latLon;
		showMapContextMenuMarker();
	}

	public void hideMapContextMenuMarker() {
		if (showContextMarker) {
			showContextMarker = false;
			view.refreshMap();
		}
	}

	public void setLocation(LatLon loc, String description){
		latLon = loc;
		if(latLon != null){
			if(description == null){
				description = new PointDescription(loc.getLatitude(), loc.getLongitude()).getFullPlainName(activity);
			}
			textView.setText(Html.fromHtml(description.replace("\n", "<br/>")));
		} else {
			textView.setText(""); //$NON-NLS-1$
		}
		layoutText();
	}
	

	public void setSelections(Map<Object, IContextMenuProvider> selections) {
		clearSelectedObjects();

		if (selections != null) {
			selectedObjects = selections;
		}
		if (!selectedObjects.isEmpty()) {
			Entry<Object, IContextMenuProvider> e = selectedObjects.entrySet().iterator().next();
			latLon = e.getValue().getObjectLocation(e.getKey());
			if(e.getValue() instanceof IContextMenuProviderSelection){
				((IContextMenuProviderSelection) e.getValue()).setSelectedObject(e.getKey());
			}
		}
	}

	private void clearSelectedObjects() {
		for(IContextMenuProvider p : this.selectedObjects.values()) {
			if(p instanceof IContextMenuProviderSelection){
				((IContextMenuProviderSelection) p).clearSelectedObjects();
			}
		}
		selectedObjects.clear();
	}

	@Override
	public boolean onLongPressEvent(PointF point, RotatedTileBox tileBox) {
		if ((Build.VERSION.SDK_INT < 14) && !view.getSettings().SCROLL_MAP_BY_GESTURES.get()) {
			if (!selectedObjects.isEmpty())
				view.showMessage(activity.getMyApplication().getLocationProvider().getNavigationHint(latLon));
			return true;
		}
		
		if(pressedInTextView(tileBox, point.x, point.y) > 0){
			setLocation(null, ""); //$NON-NLS-1$
			view.refreshMap();
			return true;
		}

		if (disableLongPressOnMap()) {
			return false;
		}
		showContextMenu(point, tileBox, true);
		view.refreshMap();
		return true;
	}

	public boolean showContextMenu(double latitude, double longitude, boolean showUnknownLocation) {
		RotatedTileBox cp = activity.getMapView().getCurrentRotatedTileBox().copy();
		float x = cp.getPixXFromLatLon(latitude, longitude);
		float y = cp.getPixYFromLatLon(latitude, longitude);
		return showContextMenu(new PointF(x, y), activity.getMapView().getCurrentRotatedTileBox(), showUnknownLocation);
	}

	public boolean showContextMenu(PointF point, RotatedTileBox tileBox, boolean showUnknownLocation) {
		LatLon latLon = selectObjectsForContextMenu(tileBox, point);
		if (latLon != null) {
			if (selectedObjects.size() == 1) {
				setLocation(null, "");
				Object selectedObj = selectedObjects.keySet().iterator().next();
				IContextMenuProvider contextObject = selectedObjects.get(selectedObj);
				showMapContextMenu(latLon, selectedObj, contextObject);
				return true;
			} else if (selectedObjects.size() > 1) {
				showContextMenuForSelectedObjects(latLon);
				return true;
			}
		} else if (showUnknownLocation) {
			setLocation(null, "");
			final double lat = tileBox.getLatFromPixel((int) point.x, (int) point.y);
			final double lon = tileBox.getLonFromPixel((int) point.x, (int) point.y);
			showMapContextMenu(new LatLon(lat, lon));
			return true;
		}
		return false;
	}

	public boolean disableSingleTap() {
		boolean res = false;
		for(OsmandMapLayer lt : view.getLayers()){
			if(lt instanceof ContextMenuLayer.IContextMenuProvider) {
				if (((IContextMenuProvider) lt).disableSingleTap()) {
					res = true;
					break;
				}
			}
		}
		return res;
	}

	public boolean disableLongPressOnMap() {
		boolean res = false;
		for (OsmandMapLayer lt : view.getLayers()) {
			if (lt instanceof ContextMenuLayer.IContextMenuProvider) {
				if (((IContextMenuProvider) lt).disableLongPressOnMap()) {
					res = true;
					break;
				}
			}
		}
		return res;
	}

	public LatLon selectObjectsForContextMenu(RotatedTileBox tileBox, PointF point) {
		clearSelectedObjects();
		List<Object> s = new ArrayList<Object>();
		LatLon latLon = null;
		for(OsmandMapLayer lt : view.getLayers()){
			if(lt instanceof ContextMenuLayer.IContextMenuProvider){
				s.clear();
				final IContextMenuProvider l = (ContextMenuLayer.IContextMenuProvider) lt;
				l.collectObjectsFromPoint(point, tileBox, s);
				for(Object o : s) {
					selectedObjects.put(o, l);
					if(l instanceof IContextMenuProviderSelection){
						((IContextMenuProviderSelection) l).setSelectedObject(o);
					}
					if(latLon == null) {
						latLon = l.getObjectLocation(o);
					}
				}
			}
		}
		return latLon;
	}

	@Override
	public boolean drawInScreenPixels() {
		return true;
	}
	
	public int pressedInTextView(RotatedTileBox tb, float px, float py) {
		if (latLon != null && textView.getText().length() > 0) {
			Rect bs = textView.getBackground().getBounds();
			Rect closes = closeButton.getDrawable().getBounds();
			int dx = (int) (px - tb.getPixXFromLatLon(latLon.getLatitude(), latLon.getLongitude()));
			int dy = (int) (py - tb.getPixYFromLatLon(latLon.getLatitude(), latLon.getLongitude()));
			int bx = dx + bs.width() / 2;
			int by = dy + bs.height();
			int dclosex = bx - bs.width() ;
			int dclosey = by;
			if (dclosex >= -closes.width() && dclosey >= 0 && dclosex <= 0 && dclosey <= closes.height()) {
				return 2;
			} else if (bs.contains(bx, by)) {
				return 1;
			}
		}
		return 0;
	}

	public boolean pressedContextMarker(RotatedTileBox tb, float px, float py) {
		if (latLon != null && showContextMarker) {
			Rect bs = contextMarker.getDrawable().getBounds();
			int dx = (int) (px - tb.getPixXFromLatLon(latLon.getLatitude(), latLon.getLongitude()));
			int dy = (int) (py - tb.getPixYFromLatLon(latLon.getLatitude(), latLon.getLongitude()));
			int bx = dx + bs.width() / 2;
			int by = dy + bs.height();
			return (bs.contains(bx, by));
		}
		return false;
	}

	public String getSelectedObjectName(){
		return getSelectedObjectInfo(true);
	}
	
	public List<PointDescription> getSelectedObjectNames() {
		List<PointDescription> list = new ArrayList<PointDescription>();
		Iterator<Entry<Object, IContextMenuProvider>> it = selectedObjects.entrySet().iterator();
		while (it.hasNext()) {
			Entry<Object, IContextMenuProvider> e = it.next();
			PointDescription onames = e.getValue().getObjectName(e.getKey());
			if (onames != null) {
				list.add(onames);
			}
		}
		return list;
	}
	
	public String getSelectedObjectDescription(){
		return getSelectedObjectInfo(false);
	}
	
	private String getSelectedObjectInfo(boolean name){
		if(!selectedObjects.isEmpty()){
			StringBuilder description = new StringBuilder(); 
			if (selectedObjects.size() > 1) {
				description.append("1. ");
			}
			Iterator<Entry<Object, IContextMenuProvider>> it = selectedObjects.entrySet().iterator();
			int i = 0;
			while(it.hasNext()) {
				Entry<Object, IContextMenuProvider> e = it.next();
				if( i > 0) {
					description.append("\n" + (i + 1) + ". ");
				}
				if(name) {
					PointDescription nm = e.getValue().getObjectName(e.getKey());
					description.append(nm.getFullPlainName(activity));
				} else {
					description.append(e.getValue().getObjectDescription(e.getKey()));
				}
				i++;
			}
			return description.toString();
		}
		return null;
	}

	@Override
	public boolean onSingleTap(PointF point, RotatedTileBox tileBox) {
		if (pressedContextMarker(tileBox, point.x, point.y)) {
			showMapContextMenu();
			return true;
		}

		boolean nativeMode = (Build.VERSION.SDK_INT >= 14) || view.getSettings().SCROLL_MAP_BY_GESTURES.get();
		int val = pressedInTextView(tileBox, point.x, point.y);
		if(selectOnMap != null) {
			LatLon latlon = tileBox.getLatLonFromPixel(point.x, point.y);
			CallbackWithObject<LatLon> cb = selectOnMap;
			cb.processResult(latlon);
			showMapContextMenu(latlon);
			selectOnMap = null;
			return true;
		}
		if (val == 2) {
			setLocation(null, ""); //$NON-NLS-1$
			view.refreshMap();
			return true;
		} else if (val == 1 || !nativeMode) {
			if (!selectedObjects.isEmpty()) {
				showContextMenuForSelectedObjects(latLon);
			} else if (nativeMode) {
				activity.getMapActions().contextMenuPoint(latLon.getLatitude(), latLon.getLongitude());
			}
			return true;
		} else if (!disableSingleTap()) {
			boolean res = showContextMenu(point, tileBox, false);
			if (res) {
				return true;
			}
		}

		activity.getContextMenu().hide();
		return false;
	}

	public void showContextMenuForSelectedObjects(final LatLon l) {
		final ContextMenuAdapter menuAdapter = new ContextMenuAdapter(activity);
		if (selectedObjects.size() > 1) {
			Builder builder = new AlertDialog.Builder(view.getContext());
			String[] d = new String[selectedObjects.size()];
			final List<Object> s = new ArrayList<Object>();
			int i = 0;
			Iterator<Entry<Object, IContextMenuProvider>> it = selectedObjects.entrySet().iterator();
			while(it.hasNext()) {
				Entry<Object, IContextMenuProvider> e = it.next();
				d[i++] = e.getValue().getObjectDescription(e.getKey());
				s.add(e.getKey());
			}
			builder.setItems(d, new OnClickListener() {
				@Override
				public void onClick(DialogInterface dialog, int which) {
					Object selectedObj = s.get(which);
					IContextMenuProvider contextObject = selectedObjects.get(selectedObj);
					showMapContextMenu(l, selectedObj, contextObject);
				}
			});
			builder.show();
		} else {
			Object selectedObj = selectedObjects.keySet().iterator().next();
			IContextMenuProvider contextObject = selectedObjects.get(selectedObj);
			showMapContextMenu(l, selectedObj, contextObject);
		}
	}

	public void showMapContextMenu() {
		activity.getContextMenu().show();
	}

	public void showMapContextMenu(LatLon latLon) {
		showMapContextMenu(latLon, null);
	}

	public void showMapContextMenu(LatLon latLon, String title) {
		showMapContextMenu(latLon, title, null, null);
	}

	public void showMapContextMenu(LatLon latLon, Object selectedObj, IContextMenuProvider contextObject) {
		showMapContextMenu(latLon, null, selectedObj, contextObject);
	}

	public void showMapContextMenu(LatLon latLon, String title, Object selectedObj, IContextMenuProvider contextObject) {
		PointDescription pointDescription;
		if (selectedObj != null && contextObject != null) {
			pointDescription = contextObject.getObjectName(selectedObj);
			LatLon objLocation = contextObject.getObjectLocation(selectedObj);
			pointDescription.setLat(objLocation.getLatitude());
			pointDescription.setLon(objLocation.getLongitude());
		} else {
			pointDescription = new PointDescription(latLon.getLatitude(), latLon.getLongitude());
			if (title != null) {
				pointDescription.setName(title);
			}
		}
		this.latLon = new LatLon(pointDescription.getLat(), pointDescription.getLon());

		showMapContextMenuMarker();
		if (selectOnMap != null) {
			activity.getContextMenu().init(pointDescription, selectedObj);
		} else {
			activity.getContextMenu().show(pointDescription, selectedObj);
		}
	}


	@Override
	public boolean onTouchEvent(MotionEvent event, RotatedTileBox tileBox) {

		if (movementListener.onTouchEvent(event)) {
			if (activity.getContextMenu().isMenuVisible()) {
				activity.getContextMenu().hide();
			}
		}

		if (latLon != null) {
			if (event.getAction() == MotionEvent.ACTION_DOWN) {
				int vl = pressedInTextView(tileBox, event.getX(), event.getY());
				if(vl == 1){
					textView.setPressed(true);
					view.refreshMap();
				} else if(vl == 2){
					closeButton.setPressed(true);
					view.refreshMap();
				}
			}
		}
		if (event.getAction() == MotionEvent.ACTION_UP || event.getAction() == MotionEvent.ACTION_CANCEL) {
			if(textView.isPressed()) {
				textView.setPressed(false);
				view.refreshMap();
			}
			if(closeButton.isPressed()) {
				closeButton.setPressed(false);
				view.refreshMap();
			}
		}
		return false;
	}

	public void setSelectedObject(Object toShow) {
		clearSelectedObjects();
		if(toShow != null){
			for(OsmandMapLayer l : view.getLayers()){
				if(l instanceof ContextMenuLayer.IContextMenuProvider){
					String des = ((ContextMenuLayer.IContextMenuProvider) l).getObjectDescription(toShow);
					if(des != null) {
						selectedObjects.put(toShow, (IContextMenuProvider) l);
						if(l instanceof IContextMenuProviderSelection){
							((IContextMenuProviderSelection) l).setSelectedObject(toShow);
						}
					}
				}
			}
		}
	}
	
	@Override
	public void onRetainNonConfigurationInstance(Map<String, Object> map) {
		map.put(KEY_LAT_LAN, latLon);
		map.put(KEY_SELECTED_OBJECTS, selectedObjects);
		map.put(KEY_DESCRIPTION, textView.getText().toString());
	}

	private class MenuLayerOnGestureListener extends GestureDetector.SimpleOnGestureListener {

		@Override
		public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
			return true;
		}

		@Override
		public boolean onScroll(MotionEvent e1, MotionEvent e2, float distanceX, float distanceY) {
			return true;
		}
	}
}
