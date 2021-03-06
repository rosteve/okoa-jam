package net.osmand.plus.mapcontextmenu.editors;

import android.annotation.TargetApi;
import android.content.Context;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v7.widget.Toolbar;
import android.util.TypedValue;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import net.osmand.plus.FavouritesDbHelper;
import net.osmand.plus.IconsCache;
import net.osmand.plus.OsmandApplication;
import net.osmand.plus.R;
import net.osmand.plus.activities.MapActivity;
import net.osmand.plus.widgets.AutoCompleteTextViewEx;

import java.util.List;

public abstract class PointEditorFragment extends Fragment {

	@Override
	public void onSaveInstanceState(Bundle outState) {
		super.onSaveInstanceState(outState);
		getEditor().saveState(outState);
	}

	@TargetApi(Build.VERSION_CODES.HONEYCOMB)
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
							 Bundle savedInstanceState) {

		if (savedInstanceState != null)
			getEditor().restoreState(savedInstanceState);

		View view = inflater.inflate(R.layout.point_editor_fragment, container, false);

		Toolbar toolbar = (Toolbar) view.findViewById(R.id.toolbar);
		toolbar.setTitle(getToolbarTitle());
		toolbar.setNavigationIcon(getMyApplication().getIconsCache().getIcon(R.drawable.abc_ic_ab_back_mtrl_am_alpha));
		toolbar.setTitleTextColor(getResources().getColor(getResIdFromAttribute(getMapActivity(), R.attr.pstsTextColor)));
		toolbar.setNavigationOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				dismiss();
			}
		});

		Button saveButton = (Button)toolbar.findViewById(R.id.save_button);
		saveButton.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				savePressed();
			}
		});

		ImageButton deleteButton = (ImageButton)toolbar.findViewById(R.id.delete_button);
		deleteButton.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				deletePressed();
			}
		});

		if (getEditor().isNew()) {
			deleteButton.setVisibility(View.GONE);
		} else {
			saveButton.setVisibility(View.GONE);
		}

		TextView headerCaption = (TextView) view.findViewById(R.id.header_caption);
		headerCaption.setText(getHeaderText());
		TextView nameCaption = (TextView) view.findViewById(R.id.name_caption);
		nameCaption.setText(getNameText());
		TextView categoryCaption = (TextView) view.findViewById(R.id.category_caption);
		categoryCaption.setText(getCategoryText());

		EditText nameEdit = (EditText) view.findViewById(R.id.name_edit);
		nameEdit.setText(getNameValue());
		AutoCompleteTextViewEx categoryEdit = (AutoCompleteTextViewEx) view.findViewById(R.id.category_edit);
		categoryEdit.setText(getCategoryValue());
		categoryEdit.setThreshold(1);
		final FavouritesDbHelper helper = getMyApplication().getFavorites();
		List<FavouritesDbHelper.FavoriteGroup> gs = helper.getFavoriteGroups();
		String[] list = new String[gs.size()];
		for(int i = 0; i < list.length; i++) {
			list[i] =gs.get(i).name;
		}
		categoryEdit.setAdapter(new ArrayAdapter<>(getMapActivity(), R.layout.list_textview, list));

		EditText descriptionEdit = (EditText) view.findViewById(R.id.description_edit);
		descriptionEdit.setText(getDescriptionValue());

		ImageView nameImage = (ImageView) view.findViewById(R.id.name_image);
		nameImage.setImageDrawable(getNameIcon());
		ImageView categoryImage = (ImageView) view.findViewById(R.id.category_image);
		categoryImage.setImageDrawable(getCategoryIcon());

		ImageView descriptionImage = (ImageView) view.findViewById(R.id.description_image);
		descriptionImage.setImageDrawable(getRowIcon(R.drawable.ic_action_note_dark));

		return view;
	}

	public Drawable getRowIcon(int iconId) {
		IconsCache iconsCache = getMyApplication().getIconsCache();
		boolean light = getMyApplication().getSettings().isLightContent();
		return iconsCache.getIcon(iconId,
				light ? R.color.icon_color : R.color.icon_color_light);
	}

	@Override
	public void onDestroyView() {
		if (!wasSaved() && !getEditor().isNew()) {
			save(false);
		}
		super.onDestroyView();
	}

	protected void savePressed() {
		save(true);
	}

	protected void deletePressed() {
		delete(true);
	}

	protected abstract boolean wasSaved();
	protected abstract void save(boolean needDismiss);
	protected abstract void delete(boolean needDismiss);

	static int getResIdFromAttribute(final Context ctx, final int attr) {
		if (attr == 0)
			return 0;
		final TypedValue typedvalueattr = new TypedValue();
		ctx.getTheme().resolveAttribute(attr, typedvalueattr, true);
		return typedvalueattr.resourceId;
	}

	public abstract PointEditor getEditor();

	public abstract String getToolbarTitle();

	protected MapActivity getMapActivity() {
		return (MapActivity)getActivity();
	}

	protected OsmandApplication getMyApplication() {
		if (getActivity() == null) {
			return null;
		}
		return (OsmandApplication) getActivity().getApplication();
	}

	public void dismiss() {
		dismiss(false);
	}

	public void dismiss(boolean includingMenu) {
		if (includingMenu) {
			//getMapActivity().getSupportFragmentManager().popBackStack(null, FragmentManager.POP_BACK_STACK_INCLUSIVE);
			getMapActivity().getSupportFragmentManager().popBackStack();
			getMapActivity().getMapLayers().getContextMenuLayer().hideMapContextMenuMarker();
			getMapActivity().getContextMenu().hide();
		} else {
			getMapActivity().getSupportFragmentManager().popBackStack();
		}
	}

	public abstract String getHeaderText();

	public String getNameText() {
		return getMapActivity().getResources().getString(R.string.favourites_edit_dialog_name);
	}
	public String getCategoryText() {
		return getMapActivity().getResources().getString(R.string.favourites_edit_dialog_category);
	}

	public abstract String getNameValue();
	public abstract String getCategoryValue();
	public abstract String getDescriptionValue();

	public abstract Drawable getNameIcon();
	public abstract Drawable getCategoryIcon();

	public String getName() {
		EditText nameEdit = (EditText) getView().findViewById(R.id.name_edit);
		return nameEdit.getText().toString().trim();
	}

	public String getCategory() {
		AutoCompleteTextViewEx categoryEdit = (AutoCompleteTextViewEx) getView().findViewById(R.id.category_edit);
		return categoryEdit.getText().toString().trim();
	}

	public String getDescription() {
		EditText descriptionEdit = (EditText) getView().findViewById(R.id.description_edit);
		return descriptionEdit.getText().toString().trim();
	}

}
