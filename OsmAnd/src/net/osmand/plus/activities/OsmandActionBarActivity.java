package net.osmand.plus.activities;

import net.osmand.plus.OsmandApplication;
import net.osmand.plus.R;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.ViewGroup;

/**
 *
 */
public class OsmandActionBarActivity extends AppCompatActivity {

	protected boolean haveHomeButton = true;

    //should be called after set content view
    protected void setupHomeButton(){
        Drawable back = ((OsmandApplication)getApplication()).getIconsCache().getIcon(R.drawable.abc_ic_ab_back_mtrl_am_alpha);
        back.setColorFilter(getResources().getColor(R.color.color_white), PorterDuff.Mode.MULTIPLY);
        getSupportActionBar().setHomeButtonEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setHomeAsUpIndicator(back);
    }

    @Override
    public void setContentView(int layoutResID) {
        super.setContentView(layoutResID);
		if (haveHomeButton) {
			setupHomeButton();
		}
    }

    @Override
    public void setContentView(View view) {
        super.setContentView(view);
		if (haveHomeButton) {
			setupHomeButton();
		}
    }

    @Override
    public void setContentView(View view, ViewGroup.LayoutParams params) {
        super.setContentView(view, params);
		if (haveHomeButton) {
			setupHomeButton();
		}
    }
}
