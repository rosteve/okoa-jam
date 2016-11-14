package net.osmand.plus.helpers;

import java.util.ArrayList;
import java.util.List;

import net.osmand.CallbackWithObject;
import net.osmand.Location;
import net.osmand.ResultMatcher;
import net.osmand.binary.RouteDataObject;
import net.osmand.custom.MyShortcuts;
import net.osmand.data.LatLon;
import net.osmand.plus.OsmAndFormatter;
import net.osmand.plus.OsmAndLocationProvider;
import net.osmand.plus.OsmandApplication;
import net.osmand.plus.R;
import net.osmand.plus.activities.MapActivity;
import net.osmand.plus.routing.RoutingHelper;
import net.osmand.plus.views.AnimateDraggingMapThread;
import net.osmand.plus.views.ContextMenuLayer;
import net.osmand.router.RoutingConfiguration;
import net.osmand.util.MapUtils;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.DialogInterface;
import android.os.Build;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class AvoidSpecificRoads {
    private List<RouteDataObject> missingRoads;
    private static List<RouteDataObject> missingRoadsJam;
    private OsmandApplication app;
    private static OsmandApplication app2;

    public AvoidSpecificRoads(OsmandApplication app) {
        this.app = app;
        app2 = app;
    }

    //	TODO Add roads to avoid once I get the Most congested roads
    public List<RouteDataObject> getMissingRoads() {
        if (missingRoads == null) {
            missingRoads = app.getDefaultRoutingConfig().getImpassableRoads();
        }
        return missingRoads;
    }

//    TODO get missing roads Jam
    public static List<RouteDataObject> getMissingRoadsJam() {
        if (missingRoadsJam == null) {
            missingRoadsJam = app2.getDefaultRoutingConfig().getImpassableRoads();
        }
        return missingRoadsJam;
    }

    protected net.osmand.router.RoutingConfiguration.Builder getBuilder() {
        return RoutingConfiguration.getDefault();
    }

    protected static net.osmand.router.RoutingConfiguration.Builder getBuilderJam() {
        return RoutingConfiguration.getDefault();
    }


    //    TODO ===== REMOVING IMPASSABLE TRAFFIC CONGESTED ROAD

    public static void removeImpassableRoadJam() {


        if (MyShortcuts.checkDefaults("ids", app2)) {

            List<RouteDataObject> roads;
            roads = app2.getDefaultRoutingConfig().getImpassableRoads();

            final ArrayList<RouteDataObject> points = new ArrayList<RouteDataObject>();
            points.addAll(roads);
            String id = MyShortcuts.getDefaults("ids", app2);

            try {
                JSONArray jsonArray = new JSONArray(id);
                for (int i = 0; i < points.size(); i++) {
                    JSONObject jsonObject = jsonArray.getJSONObject(i);
                    if (points.get(i).getName() == jsonObject.getString("name" + i)) {
                        getBuilderJam().removeImpassableRoad(points.get(i));
                        MyShortcuts.showToast("Cleared!" + i, app2);
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                            jsonArray.remove(i);
                        }
                    }
                    jsonArray = new JSONArray();
                    MyShortcuts.setDefaults("ids", jsonArray.toString(), app2);
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        } else {
            MyShortcuts.showToast("No traffic jam road reported", app2);
        }


//        final RouteDataObject obj = getItem(position);
//        getBuilder().removeImpassableRoad(obj);
    }

    public ArrayAdapter<RouteDataObject> createAdapter(final MapActivity ctx) {
        final ArrayList<RouteDataObject> points = new ArrayList<RouteDataObject>();
        points.addAll(getMissingRoads());
        final LatLon mapLocation = ctx.getMapLocation();
        return new ArrayAdapter<RouteDataObject>(ctx,
                R.layout.waypoint_reached, R.id.title, points) {

            @Override
            public View getView(final int position, View convertView, ViewGroup parent) {
                // User super class to create the View
                View v = convertView;
                if (v == null || v.findViewById(R.id.info_close) == null) {
                    v = ctx.getLayoutInflater().inflate(R.layout.waypoint_reached, null);
                }
                final RouteDataObject obj = getItem(position);
                v.findViewById(R.id.all_points).setVisibility(View.GONE);
                ((ImageView) v.findViewById(R.id.waypoint_icon)).setImageDrawable(
                        app.getIconsCache().getContentIcon(R.drawable.ic_action_road_works_dark));
                double dist = MapUtils.getDistance(mapLocation, MapUtils.get31LatitudeY(obj.getPoint31YTile(0)),
                        MapUtils.get31LongitudeX(obj.getPoint31XTile(0)));
                ((TextView) v.findViewById(R.id.waypoint_dist)).setText(OsmAndFormatter.getFormattedDistance((float) dist, app));

                ((TextView) v.findViewById(R.id.waypoint_text)).setText(getText(obj));
                ImageButton remove = (ImageButton) v.findViewById(R.id.info_close);
                remove.setVisibility(View.VISIBLE);
                remove.setImageDrawable(app.getIconsCache().getContentIcon(
                        R.drawable.ic_action_gremove_dark));
                remove.setOnClickListener(new View.OnClickListener() {

                    @Override
                    public void onClick(View v) {
                        remove(obj);
                        getBuilder().removeImpassableRoad(obj);
                        notifyDataSetChanged();
                        RoutingHelper rh = app.getRoutingHelper();
                        if (rh.isRouteCalculated() || rh.isRouteBeingCalculated()) {
                            rh.recalculateRouteDueToSettingsChange();
                        }
                    }
                });
                return v;
            }


        };
    }


    protected String getText(RouteDataObject obj) {
        return RoutingHelper.formatStreetName(obj.getName(app.getSettings().MAP_PREFERRED_LOCALE.get()),
                obj.getRef(), obj.getDestinationName(app.getSettings().MAP_PREFERRED_LOCALE.get()));
    }

    //TODO Use this to avoid roads with traffic congestion

    public void showDialog(final MapActivity mapActivity) {
        Builder bld = new AlertDialog.Builder(mapActivity);
        bld.setTitle(R.string.impassable_road);
        if (getMissingRoads().size() == 0) {
            bld.setMessage(R.string.avoid_roads_msg);
        } else {
            final ArrayAdapter<?> listAdapter = createAdapter(mapActivity);
            bld.setAdapter(listAdapter, new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    RouteDataObject obj = getMissingRoads().get(which);
                    double lat = MapUtils.get31LatitudeY(obj.getPoint31YTile(0));
                    double lon = MapUtils.get31LongitudeX(obj.getPoint31XTile(0));
                    showOnMap(app, mapActivity, lat, lon, getText(obj), dialog);
                }

            });
        }

        bld.setPositiveButton(R.string.shared_string_select_on_map, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                selectFromMap(mapActivity);
//                TODO overcoming Traffic Congestion
               /* OsmAndLocationProvider locationProvider = app.getLocationProvider();
                net.osmand.Location lastKnownLocation = locationProvider.getLastKnownLocation();
                LatLon loc = new LatLon(lastKnownLocation.getLatitude(), lastKnownLocation.getLongitude());
                findRoadJam(mapActivity,loc);*/
            }
        });
        bld.setNegativeButton(R.string.shared_string_close, null);
        bld.show();
    }


    protected void selectFromMap(final MapActivity mapActivity) {
        ContextMenuLayer cm = mapActivity.getMapLayers().getContextMenuLayer();
        cm.setSelectOnMap(new CallbackWithObject<LatLon>() {

            @Override
            public boolean processResult(LatLon result) {
                findRoad(mapActivity, result);
                return true;
            }

        });
    }

    private void findRoad(final MapActivity activity, final LatLon loc) {
        Location ll = new Location("");
        ll.setLatitude(loc.getLatitude());
        ll.setLongitude(loc.getLongitude());
        app.getLocationProvider().getRouteSegment(ll, new ResultMatcher<RouteDataObject>() {

            @Override
            public boolean publish(RouteDataObject object) {
                if (object == null) {
                    Toast.makeText(activity, R.string.error_avoid_specific_road, Toast.LENGTH_LONG).show();
                } else {
                    getBuilder().addImpassableRoad(object);
                    RoutingHelper rh = app.getRoutingHelper();
                    if (rh.isRouteCalculated() || rh.isRouteBeingCalculated()) {
                        rh.recalculateRouteDueToSettingsChange();
                    }
                    showDialog(activity);
                }
                return true;
            }

            @Override
            public boolean isCancelled() {
                return false;
            }

        });
    }


    public static void findRoadJam(final MapActivity activity, final LatLon loc) {
        Location ll = new Location("");
        ll.setLatitude(loc.getLatitude());
        ll.setLongitude(loc.getLongitude());

        app2.getLocationProvider().getRouteSegment(ll, new ResultMatcher<RouteDataObject>() {

            @Override
            public boolean publish(RouteDataObject object) {
                if (object == null) {
                    Toast.makeText(activity, R.string.error_avoid_specific_road, Toast.LENGTH_LONG).show();
                } else {
                    int i = 0;
                    if (MyShortcuts.checkDefaults("i", app2)) {
                        String j = MyShortcuts.getDefaults("i", app2);
                        i = Integer.parseInt(j);
                        i++;
                    } else {
                        int j = 0;
                        i = j;
                        MyShortcuts.setDefaults("i", i + "", app2);
                    }

                    if (MyShortcuts.checkDefaults("ids", app2)) {
                        String j = MyShortcuts.getDefaults("ids", app2);
                        try {
                            JSONArray jsonArray = new JSONArray(j);
                            JSONObject jsonObject = new JSONObject();

                            jsonObject.put("name" + i, object.getId());
                            jsonArray.put(jsonObject);
                            MyShortcuts.setDefaults("ids", jsonArray.toString(), app2);

                            Log.e("i is", i + "");
                            MyShortcuts.setDefaults("i", i + "", app2);
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    } else {
                        try {
                            JSONArray jsonArray = new JSONArray();
                            JSONObject jsonObject = new JSONObject();
                            jsonObject.put("name" + 0, object.getId());
                            jsonArray.put(jsonObject);
                            MyShortcuts.setDefaults("ids", jsonArray.toString(), app2);
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }
                    getBuilderJam().addImpassableRoad(object);

                    MyShortcuts.setDefaults("impassable", "true", app2);

                    RoutingHelper rh = app2.getRoutingHelper();
                    if (rh.isRouteCalculated() || rh.isRouteBeingCalculated()) {
                        rh.recalculateRouteDueToSettingsChange();
                    }
//					showDialog(activity);

                }
                return true;
            }

            @Override
            public boolean isCancelled() {
                return false;
            }

        });
    }

    public static void showOnMap(OsmandApplication app, Activity a, double lat, double lon, String name,
                                 DialogInterface dialog) {
        if (!(a instanceof MapActivity)) {
            return;
        }
        MapActivity ctx = (MapActivity) a;
        AnimateDraggingMapThread thread = ctx.getMapView().getAnimatedDraggingThread();
        int fZoom = ctx.getMapView().getZoom() < 15 ? 15 : ctx.getMapView().getZoom();
        if (thread.isAnimating()) {
            ctx.getMapView().setIntZoom(fZoom);
            ctx.getMapView().setLatLon(lat, lon);
        } else {
            thread.startMoving(lat, lon, fZoom, true);
        }
        ctx.getMapLayers().getContextMenuLayer().showMapContextMenu(new LatLon(lat, lon), name);
        dialog.dismiss();
    }

}
